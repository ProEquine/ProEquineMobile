class CheckMailVerificationRequestModel {
  String? email;
  String? code;

  CheckMailVerificationRequestModel({this.email, this.code});

  CheckMailVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    code = json['VerificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['VerificationCode'] = code;
    return data;
  }
}