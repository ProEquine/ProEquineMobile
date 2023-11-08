import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetALlCitiesResponseModel extends BaseResultModel{
  List<String>? cities;

  GetALlCitiesResponseModel({this.cities});

  GetALlCitiesResponseModel.fromJson(Map<String, dynamic> json) {
    cities = json['cities'].cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cities'] = cities;
    return data;
  }
}