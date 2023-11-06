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
    horseName = json['horseName'];
    horseColor = json['horseColor'];
    horseGender = json['horseGender'];
    horseDOB = json['horseDOB'];
    horseCOB = json['horseCOB'];
    breed = json['breed'];
    bloodline = json['bloodline'];
    disciplineId = json['disciplineId'];
    stableId = json['stableId'];
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
    data['disciplineId'] = disciplineId;
    data['stableId'] = stableId;
    return data;
  }
}