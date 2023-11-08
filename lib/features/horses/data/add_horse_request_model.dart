class AddHorseRequestModel {
  String? horseName;
  String? horseColor;
  String? horseGender;
  String? horseDOB;
  String? horseCOB;
  String? breed;
  String? bloodline;
  int? disciplineId;
  int? stableId;

  AddHorseRequestModel(
      {this.horseName,
        this.horseColor,
        this.horseGender,
        this.horseDOB,
        this.horseCOB,
        this.breed,
        this.bloodline,
        this.disciplineId,
        this.stableId});

  AddHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseName = json['HorseName'];
    horseColor = json['HorseColor'];
    horseGender = json['HorseGender'];
    horseDOB = json['HorseDOB'];
    horseCOB = json['HorseCOB'];
    breed = json['Breed'];
    bloodline = json['Bloodline'];
    disciplineId = json['DisciplineId'];
    stableId = json['StableId'];
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
    data['DisciplineId'] = disciplineId;
    data['StableId'] = stableId;
    return data;
  }
}