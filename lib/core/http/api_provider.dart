import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../CoreModels/base_response_model.dart';
import '../CoreModels/base_result_model.dart';
import '../constants/constants.dart';
import '../errors/HttpMethodUnCorrect.dart';
import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';
import '../utils/Printer.dart';

class ApiProvider {
  static Future<BaseResponseModel> sendObjectRequest<T extends BaseResultModel>(
      {required T Function(Map<String, dynamic>) converter,
      required String method,
      required String url,
      Map<String, dynamic>? data,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? files,
      CancelToken? cancelToken,
      bool isLongTime = false}) async {
    /// Edited Here
    var baseOptions = BaseOptions(
      connectTimeout: isLongTime ? 30 * 1000 : 15 * 1000,
    );

    Options options = Options(
      headers: headers,
      method: method,
      contentType: Headers.jsonContentType,
      receiveTimeout: 60 * 1000, // 60 seconds
      sendTimeout: 60 * 1000,
    );

    if (files != null) {
      headers?.remove(HEADER_CONTENT_TYPE);

      ///Edited
      data ??= {};

      await Future.forEach(files.entries, (MapEntry entry) async {
        if (entry.value != null || entry.key != null) {
          data?.addAll({entry.key: await MultipartFile.fromFile(entry.value)});
        }
      });
    }

    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(minutes: 1),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    final dio = Dio();
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    try {
      Response response;
      response = await Dio(baseOptions).request(url,
          queryParameters: queryParameters,
          options: options.copyWith(
            extra: {
              'cacheOptions': cacheOptions
                  .copyWith(policy: CachePolicy.forceCache)
                  .toOptions(),
            },
          ),
          cancelToken: cancelToken,
          data: files != null ? FormData.fromMap(data!) : data);
      // Get the decoded json
      if (response.extra['isCached'] == true) {
        print('Data is coming from cache');
      } else {
        print('Data is coming from server');
      }

      var decodedJson;

      if (response.data is String) {
        if (response.data.length == 0) {
          decodedJson = {"": ""};
        } else {
          decodedJson = json.decode(response.data);
        }
      } else {
        decodedJson = response.data;
      }

      Print(decodedJson);

      return BaseResponseModel.fromJson(json: decodedJson, fromJson: converter);
    }

    // Handling errors
    on DioError catch (e, s) {
      Print('catch DioError ');
      Print(e);

      Print('Stacktrace DioError ');
      Print(s);
      var error = _handleDioError(e);
      var json;
      Print('DioErrorDioErrorDioError $error');
      if (e.response != null) if (e.response?.data !=
          null) if (!(e.response?.data is String)) {
        Print(e.response?.data);
        json = e.response?.data;
      }

      return BaseResponseModel.fromJson(json: json, error: error);
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      Print(e);
      Print(stacktrace);
      return BaseResponseModel.fromJson(error: SocketError());
    } catch (e, stacktrace) {
      Print(e);
      Print(stacktrace);
      return BaseResponseModel.fromJson(error: SocketError());
    }
  }

  static BaseError _handleDioError(DioError error) {
    Print('error.type = ${(error.type)}');
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.response) {
        switch (error.response?.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 405:
            return HttpMethodUnCorrect();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else {
      return UnknownError();
    }
  }
}
