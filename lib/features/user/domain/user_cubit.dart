import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/features/user/data/check_update_email_request_model.dart';
import 'package:proequine/features/user/data/check_verification_request_model.dart';
import 'package:proequine/features/user/data/forgot_pass_response_model.dart';
import 'package:proequine/features/user/data/interests_request_model.dart';
import 'package:proequine/features/user/data/login_response_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/send_mail_request_model.dart';
import 'package:proequine/features/user/data/send_verification_request_model.dart';
import 'package:proequine/features/user/data/update_email_request_model.dart';
import 'package:proequine/features/user/domain/repo/user_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/check_mail_request_model.dart';
import '../data/login_request_model.dart';
import '../data/register_response_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> login(LoginRequestModel loginRequestModel) async {
    /// here we emit loading state while contact with server
    emit(LoginLoading());

    /// return the response from server
    var response = await UserRepository.login(loginRequestModel);

    /// if server return the same model so it's success state
    if (response is LoginResponseModel) {
      /// store our token in shared pref
      await SecureStorage().setRefreshToken(response.refreshToken!.token!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.refreshToken!.userId!);
    String? refreshToken= await SecureStorage().getRefreshToken();
    String? accessToken= await SecureStorage().getToken();
    String? userId= await SecureStorage().getUserId();
      AppSharedPreferences.phoneVerified = response.isPhoneNumberVerified;
      AppSharedPreferences.emailVerified = response.isEmailVerified;
      AppSharedPreferences.typeSelected=response.isTypeSelected;
      AppSharedPreferences.inputPhoneNumber=response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress=loginRequestModel.email!;
      Print("access token $accessToken");
      Print("refresh token $refreshToken");
      Print("userId $userId");
      Print("userId ${AppSharedPreferences.getPhoneVerified}");
      Print("email verified ${AppSharedPreferences.getEmailVerified}");

      /// this type of Printing working only on debug mode so maintains high performance app

      /// this message will show as a toast if the status is success
      emit(LoginSuccessful(message: "login successfully".tra));
    } else if (response is BaseError) {
      /// message will return from our handling errors in Dio
      Print("messaggeeeeeeeee${response.message}");
      emit(LoginError(message: response.message));
    } else if (response is Message) {
      /// this message will return from the server in case we have error
      emit(LoginError(message: response.content));
    }
  }

  Future<void> register(RegisterRequestModel registerRequestModel) async {
    emit(RegisterLoading());
    var response = await UserRepository.register(registerRequestModel);
    if (response is RegisterResponseModel) {
      await SecureStorage().setRefreshToken(response.refreshToken!.token!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.refreshToken!.userId!);
      AppSharedPreferences.inputPhoneNumber=registerRequestModel.phoneNumber!;
      AppSharedPreferences.phoneVerified=false;
      AppSharedPreferences.inputEmailAddress=registerRequestModel.email!;


      String? refreshToken= await SecureStorage().getRefreshToken();
      String? accessToken= await SecureStorage().getToken();
      String? userId= await SecureStorage().getUserId();
      Print("access token $accessToken");
      Print("refresh token $refreshToken");
      Print("userId $userId");

      emit(RegisterSuccessful(message: "Account created successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RegisterError(message: response.message));
    } else if (response is Message) {
      emit(RegisterError(message: response.content));
    }
  }

  Future<void> sendVerificationCode(
      SendVerificationRequestModel sendVerificationRequestModel) async {
    emit(SendVerificationLoading());
    var response =
        await UserRepository.sendVerification(sendVerificationRequestModel);
    if (response is EmptyModel) {
      emit(SendVerificationSuccessful(
          message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendVerificationError(message: response.message));
    } else if (response is Message) {
      emit(SendVerificationError(message: response.content));
    }
  }

  Future<void> checkVerificationCode(
      CheckVerificationRequestModel checkVerificationRequestModel) async {
    emit(CheckVerificationLoading());
    var response =
        await UserRepository.checkVerification(checkVerificationRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.phoneVerified = true;
      emit(CheckVerificationSuccessful(
          message: "Account verified successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckVerificationError(message: response.message));
    } else if (response is Message) {
      emit(CheckVerificationError(message: response.content));
    }
  }

  Future<void> forgotPassword(
      SendVerificationRequestModel sendVerificationRequestModel) async {
    emit(ForgotPasswordLoading());
    var response =
        await UserRepository.forgotPassword(sendVerificationRequestModel);
    if (response is ForgotPasswordResponseModel) {
      emit(ForgotPasswordSuccessful(model: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ForgotPasswordError(message: response.message));
    } else if (response is Message) {
      emit(ForgotPasswordError(message: response.content));
    }
  }

  Future<void> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel) async {
    emit(ResetPasswordLoading());
    var response =
        await UserRepository.resetPassword(resetPasswordRequestModel);
    if (response is EmptyModel) {
      emit(ResetPasswordSuccessful(message: "Password reset successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ResetPasswordError(message: response.message));
    } else if (response is Message) {
      emit(ResetPasswordError(message: response.content));
    }
  }

  Future<void> interests(InterestsRequestModel interestsRequestModel) async {
    emit(SelectInterestsLoading());
    var response = await UserRepository.interests(interestsRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.typeSelected = true;
      emit(SelectInterestsSuccessful(message: "Selected Successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SelectInterestsError(message: response.message));
    } else if (response is Message) {
      emit(SelectInterestsError(message: response.content));
    }
  }

  Future<void> sendMailVerificationCode(
      SendMailVerificationRequestModel sendMailVerificationRequestModel) async {
    emit(SendMailVerificationLoading());
    var response =
    await UserRepository.sendMailVerification(sendMailVerificationRequestModel);
    if (response is EmptyModel) {
      emit(SendMailVerificationSuccessful(
          message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendMailVerificationError(message: response.message));
    } else if (response is Message) {
      emit(SendMailVerificationError(message: response.content));
    }
  }

  Future<void> checkMailVerificationCode(
      CheckMailVerificationRequestModel checkMailVerificationRequestModel) async {
    emit(CheckMailVerificationLoading());
    var response =
    await UserRepository.checkMailVerification(checkMailVerificationRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.emailVerified = true;
      emit(CheckMailVerificationSuccessful(
          message: "Email verified successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckMailVerificationError(message: response.message));
    } else if (response is Message) {
      emit(CheckMailVerificationError(message: response.content));
    }
  }
  Future<void> updateMail(
      UpdateMailRequestModel updateMailRequestModel) async {
    emit(UpdateMailLoading());
    var response =
    await UserRepository.updateMail(updateMailRequestModel);
    if (response is EmptyModel) {
      emit(UpdateMailSuccessful(
          message: "code has been sent".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateMailError(message: response.message));
    } else if (response is Message) {
      emit(UpdateMailError(message: response.content));
    }
  }
  Future<void> checkUpdatedMail (
      CheckUpdateEmailRequestModel checkUpdateEmailRequestModel) async {
    emit(CheckUpdateMailLoading());
    var response =
    await UserRepository.checkUpdateMail(checkUpdateEmailRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.emailVerified = true;
      emit(CheckUpdateMailSuccessful(
          message: "Email Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckUpdateMailError(message: response.message));
    } else if (response is Message) {
      emit(CheckUpdateMailError(message: response.content));
    }
  }
  Future<void> deleteAccount(String userPhoneNumber) async {
    emit(DeleteAccountLoading());
    var response = await UserRepository.deleteAccount(userPhoneNumber);
    if (response is EmptyModel) {
      emit(SelectInterestsSuccessful(message: "Delete Successfully".tra));
    } else if (response is BaseError) {
      Print("Account Delete Error${response.message}");
      emit(DeleteAccountError(message: response.message));
    }
  }
}
