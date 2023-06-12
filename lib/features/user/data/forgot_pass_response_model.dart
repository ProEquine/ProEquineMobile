
import 'package:proequine/core/CoreModels/base_result_model.dart';

class ForgotPasswordResponseModel extends BaseResultModel {
  String? token;

  ForgotPasswordResponseModel({this.token});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}