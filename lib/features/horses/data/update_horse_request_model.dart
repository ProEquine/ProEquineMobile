import 'dart:io';

class UpdateHorseRequestModel {
  HorseObj? horseObj;
  File? image;

  UpdateHorseRequestModel({this.horseObj, this.image
    // this.image
  });

  UpdateHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseObj = json['horseObj'] != null
        ? HorseObj.fromJson(json['horseObj'])
        : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (horseObj != null) {
      data['horseObj'] = horseObj!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class HorseObj {
  String? horseName;
  String? horseColor;
  String? horseGender;
  String? horseDOB;
  String? horseCOB;
  String? breed;
  String? bloodline;
  String? horseImage;
  int? horseID;

  HorseObj(
      {this.horseName,
        this.horseColor,
        this.horseGender,
        this.horseDOB,
        this.horseCOB,
        this.breed,
        this.bloodline,
        this.horseImage,
        this.horseID});

  HorseObj.fromJson(Map<String, dynamic> json) {
    horseName = json['horseName'];
    horseColor = json['horseColor'];
    horseGender = json['horseGender'];
    horseDOB = json['horseDOB'];
    horseCOB = json['horseCOB'];
    breed = json['breed'];
    bloodline = json['bloodline'];
    horseImage = json['horseImage'];
    horseID = json['horseID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseName'] = horseName;
    data['horseColor'] = horseColor;
    data['horseGender'] = horseGender;
    data['horseDOB'] = horseDOB;
    data['horseCOB'] = horseCOB;
    data['breed'] = breed;
    data['bloodline'] = bloodline;
    data['horseImage'] = horseImage;
    data['horseID'] = horseID;
    return data;
  }
}