import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/manage_account/data/add_address_request_model.dart';
import 'package:proequine/features/manage_account/data/add_bio_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_response_model.dart';
import 'package:proequine/features/manage_account/data/delete_account_request_model.dart';
import 'package:proequine/features/manage_account/data/update_dob_request_model.dart';
import 'package:proequine/features/manage_account/data/update_main_number_request_model.dart';
import 'package:proequine/features/manage_account/data/update_name_request_model.dart';
import 'package:proequine/features/manage_account/data/update_nationality_request_model.dart';
import 'package:proequine/features/manage_account/data/update_password_response_model.dart';
import 'package:proequine/features/manage_account/data/update_secondary_number_request_model.dart';
import 'package:proequine/features/manage_account/domain/repo/manage_account_repository.dart';
import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/change_password_request_model.dart';
import '../data/edit_phone_request_model.dart';
import '../data/user_data_response_model.dart';

part 'manage_account_state.dart';

class ManageAccountCubit extends Cubit<ManageAccountState> {
  ManageAccountCubit() : super(ManageAccountInitial());

  Future<void> changePassword(
      UpdatePasswordRequestModel updatePasswordRequestModel) async {
    emit(ChangePasswordLoading());
    var response = await ManageAccountRepository.changePassword(
        updatePasswordRequestModel);
    if (response is UpdatePasswordResponseModel) {
      await SecureStorage().setRefreshToken(
          response.authenticationResponse!.refreshToken!.token!);
      await SecureStorage()
          .setToken(response.authenticationResponse!.accessToken!);
      await SecureStorage().setUserId(response.authenticationResponse!.userId!);
      AppSharedPreferences.setPersonId = response.authenticationResponse!.personId.toString();
      emit(ChangePasswordSuccessful(
          message: "Password changed successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ChangePasswordError(message: response.message));
    } else if (response is Message) {
      emit(ChangePasswordError(message: response.content));
    }
  }

  Future<void> deleteAccount(DeleteAccountRequestModel deleteAccountRequestModel) async {
    emit(DeleteAccountLoading());
    var response = await ManageAccountRepository.deleteAccount(deleteAccountRequestModel);
    if (response is EmptyModel) {
      emit(DeleteAccountSuccessful(message: "Delete Successfully".tra));
    } else if (response is BaseError) {
      Print("Account Delete Error${response.message}");
      emit(DeleteAccountError(message: response.message));
    } else if (response is Message) {
      emit(DeleteAccountError(message: response.content));
    }
  }

  Future<void> updateName(UpdateNameRequestModel updateNameRequestModel) async {
    emit(UpdateNameLoading());
    var response =
        await ManageAccountRepository.updateName(updateNameRequestModel);
    if (response is EmptyModel) {
      emit(UpdateNameSuccessful(message: "Name Updated Successfully".tra));
    } else if (response is BaseError) {
      emit(UpdateNameError(message: response.message));
    } else if (response is Message) {
      emit(UpdateNameError(message: response.content));
    }
  }

  Future<void> updateNationality(
      UpdateNationalityRequestModel updateNationalityRequestModel) async {
    emit(UpdateNationalityLoading());
    var response = await ManageAccountRepository.updateNationality(
        updateNationalityRequestModel);
    if (response is EmptyModel) {
      emit(UpdateNationalitySuccessful(
          message: "Nationality Updated Successfully".tra));
    } else if (response is BaseError) {
      emit(UpdateNationalityError(message: response.message));
    } else if (response is Message) {
      emit(UpdateNationalityError(message: response.content));
    }
  }

  Future<void> updateDOB(
      UpdateDateOfBirthRequestModel updateDateOfBirthRequestModel) async {
    emit(UpdateDOBLoading());
    var response =
        await ManageAccountRepository.updateDOB(updateDateOfBirthRequestModel);
    if (response is EmptyModel) {
      emit(UpdateDOBSuccessful(
          message: "Date Of Birth Updated Successfully".tra));
    } else if (response is BaseError) {
      emit(UpdateDOBError(message: response.message));
    } else if (response is Message) {
      emit(UpdateDOBError(message: response.content));
    }
  }

  Future<void> sendPhoneNumber(
      EditPhoneRequestModel editPhoneRequestModel) async {
    emit(SendPhoneLoading());
    var response =
        await ManageAccountRepository.sendPhoneNumber(editPhoneRequestModel);
    if (response is EmptyModel) {
      emit(SendPhoneSuccessful(message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendPhoneError(message: response.message));
    } else if (response is Message) {
      emit(SendPhoneError(message: response.content));
    }
  }

  Future<void> updatePhoneNumber(
      UpdateMainNumberRequestModel updateMainNumberRequestModel) async {
    emit(UpdatePhoneLoading());
    var response = await ManageAccountRepository.updatePhoneNumber(
        updateMainNumberRequestModel);
    if (response is EmptyModel) {
      AppSharedPreferences.phoneVerified = true;
      emit(UpdatePhoneSuccessful(message: "Phone Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdatePhoneError(message: response.message));
    } else if (response is Message) {
      emit(UpdatePhoneError(message: response.content));
    }
  }
  Future<void> updateSecondaryNumber(
      UpdateSecondaryNumberRequestModel updateSecondaryNumberRequestModel) async {
    emit(UpdateSecondaryPhoneLoading());
    var response = await ManageAccountRepository.updateSecondaryPhoneNumber(
        updateSecondaryNumberRequestModel);
    if (response is EmptyModel) {
      //
      emit(UpdatePhoneSecondarySuccessful(message: "Phone Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdatePhoneSecondaryError(message: response.message));
    } else if (response is Message) {
      emit(UpdatePhoneSecondaryError(message: response.content));
    }
  }

  Future<void> addAddress(AddAddressRequestModel addAddressRequestModel) async {
    emit(AddAddressLoading());
    var response =
        await ManageAccountRepository.addAddress(addAddressRequestModel);
    if (response is EmptyModel) {
      emit(AddAddressSuccessfully(
          message: "The Address has been added successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddAddressError(message: response.message));
    } else if (response is Message) {
      emit(AddAddressError(message: response.content));
    }
  }

  Future<void> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    emit(AddSecondaryPhoneLoading());
    var response = await ManageAccountRepository.addSecondaryNumber(
        addSecondaryNumberRequestModel);
    if (response is AddSecondaryNumberResponseModel) {
      emit(AddSecondaryPhoneSuccessful(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddSecondaryPhoneError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryPhoneError(message: response.content));
    }
  }

  Future<void> getUser() async {
    emit(GetUserLoading());
    var response = await ManageAccountRepository.getUserData();
    if (response is UserDataResponseModel) {
      String firstName = response.name!.split(' ')[0];
      AppSharedPreferences.inputName = firstName;
      emit(GetUserSuccessful(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetUserError(message: response.message));
    } else if (response is Message) {
      emit(GetUserError(message: response.content));
    }
  }

  Future<void> addBio(AddBioRequestModel addBioRequestModel) async {
    emit(AddBioLoading());
    var response = await ManageAccountRepository.addBio(addBioRequestModel);
    if (response is EmptyModel) {
      emit(AddBioSuccessful(
          message: "Social Accounts has been added successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddBioError(message: response.message));
    } else if (response is Message) {
      emit(AddBioError(message: response.content));
    }
  }

  Future<void> uploadUserImage(String image) async {
    emit(UploadImageLoading());
    var response = await ManageAccountRepository.uploadUserImage(image);
    if (response is EmptyModel) {
      emit(UploadImageSuccessful(
          message: "Profile picture has been added successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UploadImageError(message: response.message));
    } else if (response is Message) {
      emit(UploadImageError(message: response.content));
    }
  }
}
