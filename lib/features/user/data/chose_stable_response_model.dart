import 'package:proequine/core/CoreModels/base_result_model.dart';

class ChoseMainStableResponseModel extends BaseResultModel {
  bool? isChoseType;
  bool? isChoseMainStable;
  String? userName;

  ChoseMainStableResponseModel({this.isChoseType, this.isChoseMainStable, this.userName});

  ChoseMainStableResponseModel.fromJson(Map<String, dynamic> json) {
    isChoseType = json['isChoseType'];
    isChoseMainStable = json['isChoseMainStable'];
    userName = json['userName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isChoseType'] = isChoseType;
    data['isChoseMainStable'] = isChoseMainStable;
    data['userName'] = userName;
    return data;
  }
}