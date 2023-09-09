import 'package:proequine/core/CoreModels/base_result_model.dart';

class UserDataResponseModel extends BaseResultModel {
  String? email;
  String? userId;
  String? phoneNumber;
  bool? emailConfirmed;
  bool? phoneNumberConfirmed;
  String? fullName;
  String? dob;
  String? userType;
  bool? isCustomer;
  String? discipline;
  String? stable;
  bool? status;

  UserDataResponseModel(
      {this.email,
        this.userId,
        this.phoneNumber,
        this.emailConfirmed,
        this.phoneNumberConfirmed,
        this.fullName,
        this.dob,
        this.userType,
        this.isCustomer,
        this.discipline,
        this.stable,
        this.status});

  UserDataResponseModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    emailConfirmed = json['emailConfirmed'];
    phoneNumberConfirmed = json['phoneNumberConfirmed'];
    fullName = json['fullName'];
    dob = json['dob'];
    userType = json['userType'];
    isCustomer = json['isCustomer'];
    discipline = json['discipline'];
    stable = json['stable'];
    status = json['status'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userId'] = userId;
    data['phoneNumber'] = phoneNumber;
    data['emailConfirmed'] = emailConfirmed;
    data['phoneNumberConfirmed'] = phoneNumberConfirmed;
    data['fullName'] = fullName;
    data['dob'] = dob;
    data['userType'] = userType;
    data['isCustomer'] = isCustomer;
    data['discipline'] = discipline;
    data['stable'] = stable;
    data['status'] = status;
    return data;
  }
}