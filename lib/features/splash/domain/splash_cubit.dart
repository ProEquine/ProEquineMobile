import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/app_settings.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/splash/data/env_response_model.dart';
import 'package:proequine/features/splash/domain/repo/splash_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';

import '../data/refresh_request_model.dart';
import '../data/refresh_token_response.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  String? envUrl;

  Future<void> refreshToken(RefreshRequestModel requestModel) async {
    var response = await SplashRepository.refreshToken(requestModel);
    if (response is RefreshTokenResponse) {
      await SecureStorage().setRefreshToken(response.refreshToken!.token!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.refreshToken!.userId!);
      if (response is RefreshSuccessfully) {
        Print(response);
      } else if (response is BaseError) {
        Print(response);
      } else if (response is Message) {
        Print(response);
      }
    }
  }

  Future<void> getEnv(String buildNumber) async {
    var response = await SplashRepository.getTheEnvironment(buildNumber);
    if (response is EnvResponseModel) {
      await SecureStorage().setUrl(response.environmentURL!);
      AppSharedPreferences.setEnvType=response.environmentURL!;
      Print('AppSharedPreferences.getEnvType${SecureStorage().getUrl()}');
      envUrl = response.environmentURL!;
      if (response is BaseError) {
        Print(response);
      } else if (response is Message) {
        Print(response);
      }
    }
  }
// Future<void> getVersion()async{
//   var response= await SplashRepository.versionModel();
//   print('this is response for all getVersion');
//   if(response is VersionResponseModel){
//     emit(VersionSuccessful(versionModel:
//     response
//     ));
//   }
//
//   else if(response is Message){
//     emit(VersionError(message: response.content));
//   }
// }
}
