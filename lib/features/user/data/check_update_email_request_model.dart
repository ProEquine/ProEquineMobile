class CheckUpdateEmailRequestModel {
  String? newEmail;
  String? code;

  CheckUpdateEmailRequestModel({this.newEmail, this.code});

  CheckUpdateEmailRequestModel.fromJson(Map<String, dynamic> json) {
    newEmail = json['emailAddress'];
    code = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailAddress'] = newEmail;
    data['verificationCode'] = code;
    return data;
  }
}