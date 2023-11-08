import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetAllStatesResponseModel extends BaseResultModel{
  List<String>? states;

  GetAllStatesResponseModel({this.states});

  GetAllStatesResponseModel.fromJson(Map<String, dynamic> json) {
    states = json['states'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['states'] = states;
    return data;
  }
}