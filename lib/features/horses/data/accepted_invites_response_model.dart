import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../associations/data/horse_associated_requests_response_model.dart';

class AcceptedInvitesResponseModel extends BaseResultModel{
  int? count;
  List<InviteResponseModel>? rows;

  AcceptedInvitesResponseModel({this.count, this.rows});

  AcceptedInvitesResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <InviteResponseModel>[];
      json['rows'].forEach((v) {
        rows!.add(new InviteResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InviteResponseModel {
  int? id;
  int? userId;
  User? user;
  int? disciplineId;
  MainDiscipline? discipline;
  int? stableId;
  MainStable? stable;
  String? name;
  int? age;
  String? image;
  String? status;
  String? dateOfBirth;
  String? placeOfBirth;
  String? color;
  String? gender;
  String? bloodLine;
  String? breed;
  String? horseProofOwnership;
  String? horseNationalPassport;
  String? horseFEIPassport;

  InviteResponseModel(
      {this.id,
        this.userId,
        this.user,
        this.disciplineId,
        this.discipline,
        this.stableId,
        this.stable,
        this.name,
        this.age,
        this.image,
        this.status,
        this.dateOfBirth,
        this.placeOfBirth,
        this.color,
        this.gender,
        this.bloodLine,
        this.breed,
        this.horseProofOwnership,
        this.horseNationalPassport,
        this.horseFEIPassport});

  InviteResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    disciplineId = json['disciplineId'];
    discipline = json['discipline'] != null
        ? new MainDiscipline.fromJson(json['discipline'])
        : null;
    stableId = json['stableId'];
    stable =
    json['stable'] != null ? new MainStable.fromJson(json['stable']) : null;
    name = json['name'];
    age = json['age'];
    image = json['image'];
    status = json['status'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'];
    color = json['color'];
    gender = json['gender'];
    bloodLine = json['bloodLine'];
    breed = json['breed'];
    horseProofOwnership = json['horseProofOwnership'];
    horseNationalPassport = json['horseNationalPassport'];
    horseFEIPassport = json['horseFEIPassport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['disciplineId'] = this.disciplineId;
    if (this.discipline != null) {
      data['discipline'] = this.discipline!.toJson();
    }
    data['stableId'] = this.stableId;
    if (this.stable != null) {
      data['stable'] = this.stable!.toJson();
    }
    data['name'] = this.name;
    data['age'] = this.age;
    data['image'] = this.image;
    data['status'] = this.status;
    data['dateOfBirth'] = this.dateOfBirth;
    data['placeOfBirth'] = this.placeOfBirth;
    data['color'] = this.color;
    data['gender'] = this.gender;
    data['bloodLine'] = this.bloodLine;
    data['breed'] = this.breed;
    data['horseProofOwnership'] = this.horseProofOwnership;
    data['horseNationalPassport'] = this.horseNationalPassport;
    data['horseFEIPassport'] = this.horseFEIPassport;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? nationality;
  String? accessToken;
  String? refreshToken;
  Steps? steps;
  String? userName;
  bool? verifiedEmail;
  bool? verifiedPhoneNumber;
  bool? isBlocked;
  String? image;
  int? mainStableId;
  MainStable? mainStable;
  int? mainDisciplineId;
  MainDiscipline? mainDiscipline;
  String? displayName;
  String? address;
  String? country;
  String? state;
  String? city;
  String? secondNumber;

  User(
      {this.id,
        this.email,
        this.phoneNumber,
        this.roles,
        this.firstName,
        this.lastName,
        this.middleName,
        this.gender,
        this.nationality,
        this.accessToken,
        this.refreshToken,
        this.steps,
        this.userName,
        this.verifiedEmail,
        this.verifiedPhoneNumber,
        this.isBlocked,
        this.image,
        this.mainStableId,
        this.mainStable,
        this.mainDisciplineId,
        this.mainDiscipline,
        this.displayName,
        this.address,
        this.country,
        this.state,
        this.city,
        this.secondNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    gender = json['gender'];
    nationality = json['nationality'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainStable = json['mainStable'] != null
        ? new MainStable.fromJson(json['mainStable'])
        : null;
    mainDisciplineId = json['mainDisciplineId'];
    mainDiscipline = json['mainDiscipline'] != null
        ? new MainDiscipline.fromJson(json['mainDiscipline'])
        : null;
    displayName = json['displayName'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    secondNumber = json['secondNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['roles'] = this.roles;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    if (this.steps != null) {
      data['steps'] = this.steps!.toJson();
    }
    data['userName'] = this.userName;
    data['verifiedEmail'] = this.verifiedEmail;
    data['verifiedPhoneNumber'] = this.verifiedPhoneNumber;
    data['isBlocked'] = this.isBlocked;
    data['image'] = this.image;
    data['mainStableId'] = this.mainStableId;
    if (this.mainStable != null) {
      data['mainStable'] = this.mainStable!.toJson();
    }
    data['mainDisciplineId'] = this.mainDisciplineId;
    if (this.mainDiscipline != null) {
      data['mainDiscipline'] = this.mainDiscipline!.toJson();
    }
    data['displayName'] = this.displayName;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['secondNumber'] = this.secondNumber;
    return data;
  }
}
