class ChangePasswordRequestModel {
  String? phoneNumber;
  String? oldPassword;
  String? password;
  String? confirmPassword;

  ChangePasswordRequestModel(
      {this.phoneNumber,
        this.oldPassword,
        this.password,
        this.confirmPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    oldPassword = json['oldPassword'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['oldPassword'] = oldPassword;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}