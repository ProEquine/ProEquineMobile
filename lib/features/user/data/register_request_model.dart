class RegisterRequestModel {
  String? emailAddress;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? nationality;
  String? dob;
  String? phoneNumber;
  String? verificationCode;

  RegisterRequestModel(
      {this.emailAddress,
      this.password,
      this.confirmPassword,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dob,
      this.phoneNumber,
      this.verificationCode,
      this.nationality,
      this.gender});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    nationality = json['nationality'];
    dob = json['dob'];
    phoneNumber = json['mobileNumber'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailAddress'] = emailAddress;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['dob'] = dob;
    data['mobileNumber'] = phoneNumber;
    data['verificationCode'] = verificationCode;
    return data;
  }
}
