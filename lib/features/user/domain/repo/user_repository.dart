import 'package:proequine/core/CoreModels/empty_model.dart';
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

  static Future<BaseResultModel?> sendVerification(
      SendVerificationRequestModel sendVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: sendVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: true,
        url: ApiURLs.sendVerificationCode);
  }
  static Future<BaseResultModel?> checkVerification(
      CheckVerificationRequestModel checkVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: checkVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: true,
        url: ApiURLs.checkVerificationCode);
  }

  static Future<BaseResultModel?> forgotPassword(
      SendVerificationRequestModel sendVerificationRequestModel) async {
    return await RemoteDataSource.request<ForgotPasswordResponseModel>(
        converter: (json) => ForgotPasswordResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: sendVerificationRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.forgotPassword);
  }

  static Future<BaseResultModel?> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: resetPasswordRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.resetPassword);
  }
  static Future<BaseResultModel?> interests(
      InterestsRequestModel interestsRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: interestsRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: true,
        url: ApiURLs.interests);
  }
}