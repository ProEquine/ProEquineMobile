import 'package:dio/dio.dart';
import '../CoreModels/base_result_model.dart';
import '../constants/constants.dart';
import '../http/api_provider.dart';
import '../utils/printer.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class RemoteDataSource {
  static Future<BaseResultModel?> request<Response extends BaseResultModel>(
      {required Response Function(Map<String, dynamic> json) converter,
        required String method,
        required String url,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? data,
        Map<String, String>? files,
        bool withAuthentication = true,
        bool thereDeviceId = true,
        CancelToken? cancelToken,
        bool isLongTime = false}) async {
    assert(converter != null);
    assert(method != null);
    assert(url != null);

    Map<String, String> headers = {
      HEADER_CONTENT_TYPE: "application/json",
      HEADER_ACCEPT: "application/json",

    };

    /// Get the language.
    String lang = 'en';
    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);


    if (withAuthentication) {
      if (AppSharedPreferences.accessToken != null || AppSharedPreferences.accessToken != '' ) {
        headers.putIfAbsent(HEADER_AUTH, () => ('bearer ${AppSharedPreferences.accessToken}'));
      }
    }

    if (thereDeviceId) {
      if (AppSharedPreferences.hasDeviceId && AppSharedPreferences.deviceID != null) {
        headers.putIfAbsent(DEVICE_ID, () => (AppSharedPreferences.deviceID));
      } else {
      }


    }
    //ToDo remove prints
    Print.inf('HEADERS  $headers');

    Print.inf('--------------------  Start Request Body  --------------------'
        ' \n The HttpMethod & URL are : [$method: $url]');
    Print.inf('The sended Object Request is : $data');
    Print.inf('The headers is : $headers');
    Print.inf('The queryParameters is : $queryParameters \n '
        '--------------------  End Request Body  --------------------'
        ' \n');

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      converter: converter,
      headers: headers,
      queryParameters: queryParameters ?? {},
      data: data ?? {},
      files: files,
      isLongTime: isLongTime,
      cancelToken: cancelToken,
    );

    if (response.success!) {
      return response.data;
    } else {
      if (response.message != null) {
        return response.message;
      }
    }
    return null;
  }
}
