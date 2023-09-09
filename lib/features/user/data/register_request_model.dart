class RegisterRequestModel {
  String? email;
  String? password;
  String? fullName;
  String? gender;
  String? nationality;
  String? dob;
  String? phoneNumber;
  String? verificationCode;

  RegisterRequestModel(
      {this.email,
      this.password,
      this.fullName,
      this.dob,
      this.phoneNumber,
      this.verificationCode,
      this.nationality,
      this.gender});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    dob = json['dob'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    nationality = json['nationality'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fullName'] = fullName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['phoneNumber'] = phoneNumber;
    data['verificationCode'] = verificationCode;
    return data;
  }
}
