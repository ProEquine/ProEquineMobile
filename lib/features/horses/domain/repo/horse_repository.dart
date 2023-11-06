import 'package:proequine/features/horses/data/add_horse_request_model.dart';
import 'package:proequine/features/horses/data/get_user_horses_response_model.dart';
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
          "horseImage":horseImage,
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
  static Future<BaseResultModel?> updateHorse(
      UpdateHorseRequestModel updateHorseRequestModel, String horseImage) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateHorseRequestModel.toJson(),
        withAuthentication: true,
        files: {
          "horseImage":horseImage,
        },
        thereDeviceId: false,
        url: ApiURLs.updateHorse);
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
}