import '../../../core/CoreModels/base_result_model.dart';

class RefreshTokenResponse extends BaseResultModel {
  String? accessToken;
  String? refreshToken;

  RefreshTokenResponse({this.accessToken, this.refreshToken});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}