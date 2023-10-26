import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/equine_info/data/add_new_role_request_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/delete_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/delete_secondary_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/get_user_disciplines_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_roles_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_stables_response_model.dart';
import 'package:proequine/features/equine_info/data/update_main_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/update_secondary_discipline_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/update_main_discipline_request_model.dart';

class EquineInfoRepository {
  static Future<BaseResultModel?> getUserDiscipline() async {
    return await RemoteDataSource.request<GetUserDisciplinesResponseModel>(
        converter: (json) => GetUserDisciplinesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // queryParameters: refreshRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserDiscipline);
  }

  static Future<BaseResultModel?> getUserStables() async {
    return await RemoteDataSource.request<GetUserStablesResponseModel>(
        converter: (json) => GetUserStablesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // queryParameters: refreshRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserStables);
  }

  static Future<BaseResultModel?> getUserRoles() async {
    return await RemoteDataSource.request<GetUserRolesResponseModel>(
        converter: (json) => GetUserRolesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // queryParameters: refreshRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserRoles);
  }

  static Future<BaseResultModel?> updateMainDiscipline(UpdateMainDisciplineRequestModel updateMainDisciplineRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateMainDisciplineRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateMainDiscipline);
  }

  static Future<BaseResultModel?> updateMainStable(UpdateMainStableRequestModel updateMainStableRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateMainStableRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateMainStable);
  }
  static Future<BaseResultModel?> addSecondaryDiscipline(AddSecondaryDisciplineRequestModel addSecondaryDisciplineRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addSecondaryDisciplineRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addSecondaryDiscipline);
  }
  static Future<BaseResultModel?> addSecondaryStable(AddSecondaryStableRequestModel addSecondaryStableRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addSecondaryStableRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addSecondaryStable);
  }

  static Future<BaseResultModel?> addNewRole(AddRoleRequestModel addRoleRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addRoleRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addRole);
  }
  static Future<BaseResultModel?> deleteRole(AddRoleRequestModel addRoleRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        data: addRoleRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.deleteRole);
  }
  static Future<BaseResultModel?> updateSecondaryDiscipline(UpdateSecondaryDisciplineRequestModel updateSecondaryDisciplineRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateSecondaryDisciplineRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateSecondaryDiscipline);
  }
  static Future<BaseResultModel?> deleteDiscipline(DeleteDisciplineResponseModel deleteDisciplineResponseModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        data: deleteDisciplineResponseModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.deleteDiscipline);
  }

  static Future<BaseResultModel?> deleteSecondaryStable(DeleteSecondaryStableRequestModel deleteSecondaryStableRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        data: deleteSecondaryStableRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.deleteStable);
  }
}