import 'package:proequine/features/user/data/login_request_model.dart';
import 'package:proequine/features/user/data/login_response_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class UserRepository {
  static Future<BaseResultModel?> login(
      LoginRequestModel loginRequestModel) async {
    return await RemoteDataSource.request<LoginResponseModel>(
        converter: (json) => LoginResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: loginRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: true,
        url: ApiURLs.loginUSER);
  }
  static Future<BaseResultModel?> register(
      RegisterRequestModel registerRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: registerRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: true,
        url: ApiURLs.registerUSER);
  }
}