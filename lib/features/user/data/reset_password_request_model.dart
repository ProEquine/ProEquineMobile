class ResetPasswordRequestModel {
  String? token;
  String? code;
  String? phoneNumber;
  String? password;
  String? confirmPassword;

  ResetPasswordRequestModel(
      {this.token,
        this.code,
        this.phoneNumber,
        this.password,
        this.confirmPassword});

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    code = json['code'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['code'] = code;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}