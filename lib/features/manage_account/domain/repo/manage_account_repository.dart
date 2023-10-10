import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/change_password_request_model.dart';
import '../../data/edit_phone_request_model.dart';
import '../../data/update_phone_request_model.dart';
import '../../data/user_data_response_model.dart';

class ManageAccountRepository {
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

  static Future<BaseResultModel?> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    return await RemoteDataSource.request<AddSecondaryNumberResponseModel>(
        converter: (json) => AddSecondaryNumberResponseModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refresh,
        data: addSecondaryNumberRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updatePhone);
  }
  static Future<BaseResultModel?> getUserData() async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: const Duration(seconds: 20),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserData);
  }
}