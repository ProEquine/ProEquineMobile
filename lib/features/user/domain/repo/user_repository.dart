import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/user/data/check_mail_request_model.dart';
import 'package:proequine/features/user/data/check_update_email_request_model.dart';
import 'package:proequine/features/user/data/check_verification_request_model.dart';
import 'package:proequine/features/user/data/chose_stable_request_model.dart';
import 'package:proequine/features/user/data/get_disiplines_response_model.dart';
import 'package:proequine/features/user/data/get_stables_response_model.dart';
import 'package:proequine/features/user/data/interests_request_model.dart';
import 'package:proequine/features/user/data/login_request_model.dart';
import 'package:proequine/features/user/data/login_response_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/reset_password_response_model.dart';
import 'package:proequine/features/user/data/send_mail_request_model.dart';
import 'package:proequine/features/user/data/send_verification_request_model.dart';
import 'package:proequine/features/user/data/send_verify_request_forgot_password.dart';
import 'package:proequine/features/user/data/update_email_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/chose_stable_response_model.dart';

class UserRepository {
  static Future<BaseResultModel?> login(
      LoginRequestModel loginRequestModel) async {
    return await RemoteDataSource.request<LoginResponseModel>(
        converter: (json) => LoginResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: loginRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.loginUSER);
  }

  static Future<BaseResultModel?> register(
      RegisterRequestModel registerRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: registerRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.registerUSER);
  }

  static Future<BaseResultModel?> sendVerification(
      SendVerificationRequestModel sendVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        queryParameters: sendVerificationRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.sendVerificationCode);
  }
  static Future<BaseResultModel?> sendVerificationCodeForgotPassword(
      SendForgotPasswordVerifyRequestModel sendForgotPasswordVerifyRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        queryParameters: sendForgotPasswordVerifyRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.forgotPassword);
  }

  static Future<BaseResultModel?> checkUsername(String username) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          'UserName': username,
          "personId": int.parse(AppSharedPreferences.personId)
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateUserName);
  }

  static Future<BaseResultModel?> checkVerification(
      CheckVerificationRequestModel checkVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: checkVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.checkVerificationCode);
  }

  // static Future<BaseResultModel?> forgotPassword(
  //     SendMailVerificationRequestModel sendVerificationRequestModel) async {
  //   return await RemoteDataSource.request<EmptyModel>(
  //       converter: (json) => EmptyModel.fromJson(json),
  //       method: HttpMethod.POST,
  //       queryParameters: sendVerificationRequestModel.toJson(),
  //       withAuthentication: false,
  //       thereDeviceId: false,
  //       url: ApiURLs.sendVerificationEmail);
  // }

  static Future<BaseResultModel?> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel) async {
    return await RemoteDataSource.request<ResetPasswordResponseModel>(
        converter: (json) => ResetPasswordResponseModel.fromJson(json),
        method: HttpMethod.PUT,
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

  static Future<BaseResultModel?> choseStable(
      ChoseStableRequestModel choseStableRequestModel) async {
    return await RemoteDataSource.request<ChoseMainStableResponseModel>(
        converter: (json) => ChoseMainStableResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: choseStableRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: true,
        url: ApiURLs.choseStables);
  }

  static Future<BaseResultModel?> getStables() async {
    return await RemoteDataSource.request<GetStablesResponseModel>(
        converter: (json) => GetStablesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        policy: CachePolicy.refresh,
        refreshDuration: const Duration(seconds: 20),
        thereDeviceId: true,
        url: ApiURLs.getStables);
  }
  static Future<BaseResultModel?> getDisciplines() async {
    return await RemoteDataSource.request<GetAllDisciplinesResponseModel>(
        converter: (json) => GetAllDisciplinesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        policy: CachePolicy.refresh,
        refreshDuration: const Duration(seconds: 20),
        thereDeviceId: true,
        url: ApiURLs.getDisciplines);
  }

  static Future<BaseResultModel?> sendMailVerification(
      SendMailVerificationRequestModel sendMailVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        queryParameters: sendMailVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendVerificationEmail);
  }

  static Future<BaseResultModel?> checkMailVerification(
      CheckMailVerificationRequestModel
          checkMailVerificationRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refresh,
        queryParameters: checkMailVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.checkVerificationEmail);
  }

  static Future<BaseResultModel?> updateMail(
      UpdateMailRequestModel updateMailRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refreshForceCache,
        data: updateMailRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateMail);
  }

  static Future<BaseResultModel?> checkUpdateMail(
      CheckUpdateEmailRequestModel checkUpdateEmailRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: checkUpdateEmailRequestModel.toJson(),
        withAuthentication: true,
        // policy: CachePolicy.refreshForceCache,
        thereDeviceId: false,
        url: ApiURLs.checkUpdateMail);
  }
}
