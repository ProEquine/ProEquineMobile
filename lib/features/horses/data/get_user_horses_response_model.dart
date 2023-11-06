import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetAllHorsesResponseModel extends BaseResultModel {
  List<UserHorseList>? userHorseList;

  GetAllHorsesResponseModel({this.userHorseList});

  GetAllHorsesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['userHorseList'] != null) {
      userHorseList = <UserHorseList>[];
      json['userHorseList'].forEach((v) {
        userHorseList!.add(UserHorseList.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userHorseList != null) {
      data['userHorseList'] = userHorseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserHorseList {
  int? horseId;
  String? horseName;
  String? horseGender;
  int? horseAge;
  String? horseCondition;
  bool? horseIsVerified;
  String? horseImage;
  String? breed;
  String? bloodline;
  DisciplineDetails? disciplineDetails;
  StableDetails? stableDetails;

  UserHorseList(
      {this.horseId,
      this.horseName,
      this.horseGender,
      this.horseAge,
      this.horseCondition,
      this.horseIsVerified,
      this.horseImage,
      this.breed,
      this.bloodline,
      this.disciplineDetails,
      this.stableDetails});

  UserHorseList.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    horseName = json['horseName'];
    horseGender = json['horseGender'];
    horseAge = json['horseAge'];
    horseCondition = json['horseCondition'];
    horseIsVerified = json['horseIsVerified'];
    horseImage = json['horseImage'];
    breed = json['breed'];
    bloodline = json['bloodline'];
    disciplineDetails = json['disciplineDetails'] != null
        ? DisciplineDetails.fromJson(json['disciplineDetails'])
        : null;
    stableDetails = json['stableDetails'] != null
        ? StableDetails.fromJson(json['stableDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['horseName'] = horseName;
    data['horseGender'] = horseGender;
    data['horseAge'] = horseAge;
    data['horseCondition'] = horseCondition;
    data['horseIsVerified'] = horseIsVerified;
    data['horseImage'] = horseImage;
    data['breed'] = breed;
    data['bloodline'] = bloodline;
    if (disciplineDetails != null) {
      data['disciplineDetails'] = disciplineDetails!.toJson();
    }
    if (stableDetails != null) {
      data['stableDetails'] = stableDetails!.toJson();
    }
    return data;
  }
}

class DisciplineDetails {
  int? disciplineId;
  String? disciplineTitle;

  DisciplineDetails({this.disciplineId, this.disciplineTitle});

  DisciplineDetails.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];
    disciplineTitle = json['disciplineTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    data['disciplineTitle'] = disciplineTitle;
    return data;
  }
}

class StableDetails {
  int? stableId;
  String? stableName;

  StableDetails({this.stableId, this.stableName});

  StableDetails.fromJson(Map<String, dynamic> json) {
    stableId = json['stableId'];
    stableName = json['stableName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stableId'] = stableId;
    data['stableName'] = stableName;
    return data;
  }
}
