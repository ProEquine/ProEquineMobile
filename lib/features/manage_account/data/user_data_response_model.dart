import 'package:proequine/core/CoreModels/base_result_model.dart';

class UserDataResponseModel extends BaseResultModel {
  String? name;
  int? peid;
  String? userName;
  String? email;
  String? dob;
  String? nationality;
  String? phoneNumber;
  String? country;
  String? state;
  String? city;
  String? address;
  List<SecondaryPhoneNumbers>? secondaryPhoneNumbers;
  String? userPhoto;

  UserDataResponseModel(
      {this.name,
        this.peid,
        this.userName,
        this.email,
        this.dob,
        this.nationality,
        this.phoneNumber,
        this.country,
        this.state,
        this.city,
        this.address,
        this.secondaryPhoneNumbers,
        this.userPhoto});

  UserDataResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    peid = json['peid'];
    userName = json['userName'];
    email = json['email'];
    dob = json['dob'];
    nationality = json['nationality'];
    phoneNumber = json['phoneNumber'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    if (json['secondaryPhoneNumbers'] != null) {
      secondaryPhoneNumbers = <SecondaryPhoneNumbers>[];
      json['secondaryPhoneNumbers'].forEach((v) {
        secondaryPhoneNumbers!.add(SecondaryPhoneNumbers.fromJson(v));
      });
    }
    userPhoto = json['userPhoto'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['peid'] = peid;
    data['userName'] = userName;
    data['email'] = email;
    data['dob'] = dob;
    data['nationality'] = nationality;
    data['phoneNumber'] = phoneNumber;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['address'] = address;
    if (secondaryPhoneNumbers != null) {
      data['secondaryPhoneNumbers'] =
          secondaryPhoneNumbers!.map((v) => v.toJson()).toList();
    }
    data['userPhoto'] = userPhoto;
    return data;
  }
}

class SecondaryPhoneNumbers {
  String? phoneNumber;
  String? title;

  SecondaryPhoneNumbers({this.phoneNumber, this.title});

  SecondaryPhoneNumbers.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = phoneNumber;
    data['title'] = title;
    return data;
  }
}