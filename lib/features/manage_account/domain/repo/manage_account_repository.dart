import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/manage_account/data/add_address_request_model.dart';
import 'package:proequine/features/manage_account/data/add_bio_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_request_model.dart';
import 'package:proequine/features/manage_account/data/add_secondary_number_response_model.dart';
import 'package:proequine/features/manage_account/data/delete_account_request_model.dart';
import 'package:proequine/features/manage_account/data/update_dob_request_model.dart';
import 'package:proequine/features/manage_account/data/update_name_request_model.dart';
import 'package:proequine/features/manage_account/data/update_nationality_request_model.dart';
import 'package:proequine/features/manage_account/data/update_password_response_model.dart';
import 'package:proequine/features/manage_account/data/update_secondary_number_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/change_password_request_model.dart';
import '../../data/edit_phone_request_model.dart';
import '../../data/update_main_number_request_model.dart';
import '../../data/update_phone_request_model.dart';
import '../../data/user_data_response_model.dart';

class ManageAccountRepository {
  static Future<BaseResultModel?> changePassword(
      UpdatePasswordRequestModel updatePasswordRequestModel) async {
    return await RemoteDataSource.request<UpdatePasswordResponseModel>(
        converter: (json) => UpdatePasswordResponseModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updatePasswordRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.changePassword);
  }
  static Future<BaseResultModel?> addBio(
      AddBioRequestModel addBioRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addBioRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addBio);
  }
  static Future<BaseResultModel?> uploadUserImage(
      String image) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        files:{
          "file": image,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.uploadImage);
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
      UpdateMainNumberRequestModel updatePhoneRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        // policy: CachePolicy.refresh,
        data: updatePhoneRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updatePhone);
  }
  static Future<BaseResultModel?> updateSecondaryPhoneNumber(
      UpdateSecondaryNumberRequestModel updateSecondaryNumberRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        // policy: CachePolicy.refresh,
        data: updateSecondaryNumberRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateSecondaryPhone);
  }

  static Future<BaseResultModel?> addAddress(
      AddAddressRequestModel addAddressRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refresh,
        data: addAddressRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addAddress);
  }

  static Future<BaseResultModel?> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    return await RemoteDataSource.request<AddSecondaryNumberResponseModel>(
        converter: (json) => AddSecondaryNumberResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: addSecondaryNumberRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addSecondaryNumber);
  }
  static Future<BaseResultModel?> getUserData() async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: const Duration(seconds: 4),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserData);
  }
  static Future<BaseResultModel?> deleteAccount(DeleteAccountRequestModel deleteAccountRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        data: deleteAccountRequestModel.toJson(),
        thereDeviceId: true,
        url: ApiURLs.deleteUser);
  }
  static Future<BaseResultModel?> updateName(UpdateNameRequestModel updateNameRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        withAuthentication: true,
        data: updateNameRequestModel.toJson(),
        thereDeviceId: true,
        url: ApiURLs.updateName);
  }

  static Future<BaseResultModel?> updateNationality(UpdateNationalityRequestModel updateNationalityRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        withAuthentication: true,
        data: updateNationalityRequestModel.toJson(),
        thereDeviceId: true,
        url: ApiURLs.updateNationality);
  }
  static Future<BaseResultModel?> updateDOB(UpdateDateOfBirthRequestModel updateDateOfBirthRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        withAuthentication: true,
        data: updateDateOfBirthRequestModel.toJson(),
        thereDeviceId: true,
        url: ApiURLs.updateDOB);
  }
}