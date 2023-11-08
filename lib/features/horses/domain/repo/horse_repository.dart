import 'dart:io';

import 'package:proequine/features/horses/data/add_horse_document_request_model.dart';
import 'package:proequine/features/horses/data/add_horse_request_model.dart';
import 'package:proequine/features/horses/data/edit_document_request_model.dart';
import 'package:proequine/features/horses/data/get_horses_documents_response_model.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
import 'package:proequine/features/horses/data/remove_horse_request_model.dart';
import 'package:proequine/features/horses/data/update_condition_request_model.dart';
import 'package:proequine/features/horses/data/update_horse_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class HorseRepository{

  static Future<BaseResultModel?> addHorse(
      AddHorseRequestModel addHorseRequestModel, String horseImage) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addHorseRequestModel.toJson(),
        withAuthentication: true,
        files: {
          "file":horseImage,
        },
        thereDeviceId: false,
        url: ApiURLs.addHorse);
  }
  static Future<BaseResultModel?> getHorses() async {
    return await RemoteDataSource.request<GetAllHorsesResponseModel>(
        converter: (json) => GetAllHorsesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getHorses);
  }
  static Future<BaseResultModel?> getDocuments(int horseId) async {
    return await RemoteDataSource.request<AllHorsesDocumentsResponseModel>(
        converter: (json) => AllHorsesDocumentsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "horseId":horseId,
        },
        thereDeviceId: false,
        url: ApiURLs.allDocuments);
  }
  static Future<BaseResultModel?> updateHorse(
      UpdateHorseRequestModel updateHorseRequestModel ) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateHorseRequestModel.toJson(),
        withAuthentication: true,
        // files: {
        //   "file":image.path,
        // },
        thereDeviceId: false,
        url: ApiURLs.updateHorse);
  }
  static Future<BaseResultModel?> verifyHorse({
      int? horseId, String? profOwnerFile, String? nationalPassport, String? feiPassport }) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "HorseId":horseId
        },
        withAuthentication: true,
        files: {
          "ProofOfOwnerFile":profOwnerFile!,
          "NationalPassportFile":nationalPassport!,
          "FEIPassportFile":feiPassport!,
        },
        thereDeviceId: false,
        url: ApiURLs.verifyHorse);
  }
  static Future<BaseResultModel?> updateHorseCondition(
      UpdateHorseConditionRequestModel updateHorseConditionRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateHorseConditionRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateHorseCondition);
  }
  static Future<BaseResultModel?> removeHorse(
      RemoveHorseRequestModel removeHorseRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        data: removeHorseRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.removeHorse);
  }

  static Future<BaseResultModel?> addHorseDocument(
      AddHorseDocumentRequestModel addHorseDocumentRequestModel, String file) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addHorseDocumentRequestModel.toJson(),
        files: {
          "file":file
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addHorseDocument);
  }
  static Future<BaseResultModel?> editHorseDocument(
      EditHorseDocumentRequestModel editHorseDocumentRequestModel, String file) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: editHorseDocumentRequestModel.toJson(),
        files: {
          "file":file
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.editHorseDocument);
  }

  static Future<BaseResultModel?> removeHorseDocument(
      int docId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        queryParameters:{
          "HorseDocId":docId,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.removeHorseDocument);
  }
}