class CheckUpdateEmailRequestModel {
  String? newEmail;
  String? previousEmail;
  String? code;

  CheckUpdateEmailRequestModel({this.newEmail, this.previousEmail, this.code});

  CheckUpdateEmailRequestModel.fromJson(Map<String, dynamic> json) {
    newEmail = json['newEmail'];
    previousEmail = json['previousEmail'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newEmail'] = newEmail;
    data['previousEmail'] = previousEmail;
    data['code'] = code;
    return data;
  }
}