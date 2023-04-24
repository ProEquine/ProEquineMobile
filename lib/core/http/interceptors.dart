import 'package:dio/dio.dart';

import '../utils/Printer.dart';

class CustomInterceptors extends Interceptor {
  Dio previous;

  // Dio refreshDio = Dio();

  CustomInterceptors(this.previous);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Print.inf(
      'path:${options.baseUrl}${options.path}\n\n'
      'headers:${options.headers}\n\n'
      'queryParameters:${options.queryParameters}\n\n'
      'data:${options.data}\n\n'
      'extra:${options.extra}\n\n'
      'requestEncoder:${options.requestEncoder}',
    );

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // String? message = err.response?.data["message"];

    // throw ErrorHandler()(
    //   BaseResponseModel(
    //     statusCode: err.response!.statusCode,
    //     message: Message(content: err.response!.statusMessage ?? 'error'),
    //     success: false,
    //   ),
    // );
    Print.war(err);
    super.onError(err, handler);
    // Print.war(message);
    // if (err.error is SocketException) {
    // } else if (err.response?.statusCode == 401) {
    //   super.onError(err, handler);
    // } else if (err.response?.statusCode == 403) {
    //   super.onError(err, handler);
    // } else if (err.response?.statusCode == 422) {
    //   super.onError(err, handler);
    // } else if (err.response?.statusCode! >= 500) {
    //   super.onError(err, handler);
    // }
  }
}
