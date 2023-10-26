class ResetPasswordRequestModel {
  String? email;
  String? newPassword;
  String? verificationCode;

  ResetPasswordRequestModel(
      {this.email, this.newPassword, this.verificationCode});

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    newPassword = json['newPassword'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['newPassword'] = newPassword;
    data['verificationCode'] = verificationCode;
    return data;
  }
}