

import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/splash/domain/repo/splash_repo.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';

import '../data/refresh_request_model.dart';
import '../data/refresh_token_response.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());



  Future<void> refreshToken(RefreshRequestModel requestModel) async {
    var response = await SplashRepository.refreshToken(requestModel);
    if (response is RefreshTokenResponse) {
      await SecureStorage().setRefreshToken(response.refreshToken!.token!);
      await SecureStorage().setUserId(response.refreshToken!.userId!);
      if (response is RefreshSuccessfully) {
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
