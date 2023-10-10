import 'package:proequine/core/CoreModels/base_result_model.dart';

class RegisterResponseModel extends BaseResultModel {
  String? accessToken;
  RefreshToken? refreshToken;
  String? userId;
  bool? isChooseMainStable;
  int? personId;

  RegisterResponseModel(
      {this.accessToken,
        this.refreshToken,
        this.userId,
        this.isChooseMainStable,
        this.personId});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'] != null
        ? RefreshToken.fromJson(json['refreshToken'])
        : null;
    userId = json['userId'];
    isChooseMainStable = json['isChooseMainStable'];
    personId = json['personId'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (refreshToken != null) {
      data['refreshToken'] = refreshToken!.toJson();
    }
    data['userId'] = userId;
    data['isChooseMainStable'] = isChooseMainStable;
    data['personId'] = personId;
    return data;
  }
}

class RefreshToken {
  String? userId;
  String? token;
  String? expires;
  bool? isExpired;
  bool? isActive;

  RefreshToken(
      {this.userId, this.token, this.expires, this.isExpired, this.isActive});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    token = json['token'];
    expires = json['expires'];
    isExpired = json['isExpired'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['token'] = token;
    data['expires'] = expires;
    data['isExpired'] = isExpired;
    data['isActive'] = isActive;
    return data;
  }
}