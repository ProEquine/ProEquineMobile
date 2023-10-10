import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_response_model.dart';
import 'package:proequine/features/manage_account/domain/repo/manage_account_repository.dart';
import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/change_password_request_model.dart';
import '../data/edit_phone_request_model.dart';
import '../data/update_phone_request_model.dart';
import '../data/user_data_response_model.dart';

part 'manage_account_state.dart';

class ManageAccountCubit extends Cubit<ManageAccountState> {
  ManageAccountCubit() : super(ManageAccountInitial());

  Future<void> changePassword(
      ChangePasswordRequestModel changePasswordRequestModel) async {
    emit(ChangePasswordLoading());
    var response =
    await ManageAccountRepository.changePassword(changePasswordRequestModel);
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
    await ManageAccountRepository.sendPhoneNumber(editPhoneRequestModel);
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
    await ManageAccountRepository.updatePhoneNumber(updatePhoneRequestModel);
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


  Future<void> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    emit(AddSecondaryPhoneLoading());
    var response =
    await ManageAccountRepository.addSecondaryNumber(addSecondaryNumberRequestModel);
    if (response is AddSecondaryNumberResponseModel) {

      emit(AddSecondaryPhoneSuccessful(
          responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddSecondaryPhoneError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryPhoneError(message: response.content));
    }
  }

  Future<void> getUser() async {
    emit(GetUserLoading());
    var response =
    await ManageAccountRepository.getUserData();
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
