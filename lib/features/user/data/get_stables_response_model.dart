import 'package:proequine/core/CoreModels/base_result_model.dart';
class GetStablesResponseModel extends BaseResultModel {
  List<Stable>? data;

  GetStablesResponseModel({this.data});

  GetStablesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Stable>[];
      json['data'].forEach((v) {
        data?.add(Stable.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class Stable {
  int? stableId;
  String? stableName;

  Stable({this.stableId, this.stableName});

  Stable.fromJson(Map<String, dynamic> json) {
    stableId = json['stableId'];
    stableName = json['stableName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stableId'] = stableId;
    data['stableName'] = stableName;
    return data;
  }
}