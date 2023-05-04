class RefreshRequestModel {
  String? userId;
  String? refreshToken;


  RefreshRequestModel({
    this.refreshToken,
    this.userId,
  });

  RefreshRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    refreshToken = json['refreshToken'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['refreshToken'] = refreshToken;
    return data;
  }
}