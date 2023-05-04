class RegisterRequestModel {
  String? email;
  String? password;
  String? fullName;
  String? dob;
  String? phoneNumber;

  RegisterRequestModel({this.email, this.password,this.fullName,this.dob,this.phoneNumber});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    dob = json['dob'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fullName'] = fullName;
    data['dob'] = dob;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}