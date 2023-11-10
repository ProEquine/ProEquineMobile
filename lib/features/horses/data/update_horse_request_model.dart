import 'dart:io';


class UpdateHorseRequestModel {
  String? horseName;
  String? horseColor;
  String? horseGender;
  String? horseDOB;
  String? horseCOB;
  String? breed;
  String? bloodline;
  String? horseImage;
  int? horseID;

  UpdateHorseRequestModel(
      {this.horseName,
        this.horseColor,
        this.horseGender,
        this.horseDOB,
        this.horseCOB,
        this.breed,
        this.bloodline,
        this.horseImage,
        this.horseID});

  UpdateHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseName = json['HorseName'];
    horseColor = json['HorseColor'];
    horseGender = json['HorseGender'];
    horseDOB = json['HorseDOB'];
    horseCOB = json['horseCOB'];
    breed = json['Breed'];
    bloodline = json['Bloodline'];
    horseImage = json['HorseImage'];
    horseID = json['HorseID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HorseName'] = horseName;
    data['HorseColor'] = horseColor;
    data['HorseGender'] = horseGender;
    data['HorseDOB'] = horseDOB;
    data['HorseCOB'] = horseCOB;
    data['Breed'] = breed;
    data['Bloodline'] = bloodline;
    data['HorseImage'] = horseImage;
    data['HorseID'] = horseID;
    return data;
  }
}