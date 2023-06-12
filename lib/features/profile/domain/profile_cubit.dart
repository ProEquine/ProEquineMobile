import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/profile/data/change_password_request_model.dart';
import 'package:proequine/features/profile/data/support_request_model.dart';
import 'package:proequine/features/profile/data/update_phone_request_model.dart';
import 'package:proequine/features/profile/data/user_data_response_model.dart';
import 'package:proequine/features/profile/domain/repo/profile_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/edit_phone_request_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> changePassword(
      ChangePasswordRequestModel changePasswordRequestModel) async {
    emit(ChangePasswordLoading());
    var response =
    await ProfileRepository.changePassword(changePasswordRequestModel);
    if (response is EmptyModel) {
      emit(ChangePasswordSuccessful(
          message: "Password changed successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ChangePasswordError(message: response.message));
    } else if (response is Message) {
      emit(ChangePasswordError(message: response.content));
    }
  }

  Future<void> sendPhoneNumber(
      EditPhoneRequestModel editPhoneRequestModel) async {
    emit(SendPhoneLoading());
    var response =
    await ProfileRepository.sendPhoneNumber(editPhoneRequestModel);
    if (response is EmptyModel) {
      emit(SendPhoneSuccessful(
          message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendPhoneError(message: response.message));
    } else if (response is Message) {
      emit(SendPhoneError(message: response.content));
    }
  }

  Future<void> updatePhoneNumber(
      UpdatePhoneRequestModel updatePhoneRequestModel) async {
    emit(UpdatePhoneLoading());
    var response =
    await ProfileRepository.updatePhoneNumber(updatePhoneRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.phoneVerified = true;
      emit(UpdatePhoneSuccessful(
          message: "Phone Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdatePhoneError(message: response.message));
    } else if (response is Message) {
      emit(UpdatePhoneError(message: response.content));
    }
  }

  Future<void> contactSupport(
      SupportRequestModel supportRequestModel) async {
    emit(ContactSupportLoading());
    var response =
    await ProfileRepository.contactSupport(supportRequestModel);
    if (response is EmptyModel) {
      emit(ContactSupportSuccessful(
          message: "Your Message Received Successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ContactSupportError(message: response.message));
    } else if (response is Message) {
      emit(ContactSupportError(message: response.content));
    }
  }

  Future<void> getUser(String phone) async {
    emit(GetUserLoading());
    var response =
    await ProfileRepository.getUserData(phone);
    if (response is UserDataResponseModel) {
      emit(GetUserSuccessful(
          responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetUserError(message: response.message));
    } else if (response is Message) {
      emit(GetUserError(message: response.content));
    }
  }
}
