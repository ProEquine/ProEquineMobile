import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/profile/data/change_password_request_model.dart';
import 'package:proequine/features/profile/data/edit_phone_request_model.dart';
import 'package:proequine/features/profile/data/support_request_model.dart';
import 'package:proequine/features/profile/data/update_phone_request_model.dart';
import 'package:proequine/features/profile/data/user_data_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class ProfileRepository {
  static Future<BaseResultModel?> changePassword(
      ChangePasswordRequestModel changePasswordRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: changePasswordRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.changePassword);
  }
  static Future<BaseResultModel?> sendPhoneNumber(
      EditPhoneRequestModel editPhoneRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: editPhoneRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendPhone);
  }
  static Future<BaseResultModel?> updatePhoneNumber(
      UpdatePhoneRequestModel updatePhoneRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refresh,
        data: updatePhoneRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updatePhone);
  }
  static Future<BaseResultModel?> contactSupport(
      SupportRequestModel supportRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: supportRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.contactSupport);
  }
  static Future<BaseResultModel?> getUserData(String phone) async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: Duration(seconds: 30),
        queryParameters: {
          "phoneNumber":phone,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserData);
  }
}