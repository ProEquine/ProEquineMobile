import 'package:proequine/core/CoreModels/base_result_model.dart';

class AddSecondaryNumberResponseModel extends BaseResultModel {
  String? personPhoneNumber;
  int? personId;

  AddSecondaryNumberResponseModel({this.personPhoneNumber, this.personId});

  AddSecondaryNumberResponseModel.fromJson(Map<String, dynamic> json) {
    personPhoneNumber = json['personPhoneNumber'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personPhoneNumber'] = personPhoneNumber;
    data['personId'] = personId;
    return data;
  }
}