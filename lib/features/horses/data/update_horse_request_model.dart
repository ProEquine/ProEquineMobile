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