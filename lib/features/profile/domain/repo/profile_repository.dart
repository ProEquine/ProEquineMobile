import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/profile/data/change_password_request_model.dart';
import 'package:proequine/features/profile/data/edit_phone_request_model.dart';
import 'package:proequine/features/profile/data/support_request_model.dart';
import 'package:proequine/features/profile/data/update_phone_request_model.dart';
import 'package:proequine/features/user/data/check_verification_request_model.dart';
import 'package:proequine/features/user/data/forgot_pass_response-model.dart';
import 'package:proequine/features/user/data/interests_request_model.dart';
import 'package:proequine/features/user/data/login_request_model.dart';
import 'package:proequine/features/user/data/login_response_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/send_verification_request_model.dart';

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
}