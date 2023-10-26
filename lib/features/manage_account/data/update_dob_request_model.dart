class UpdateDateOfBirthRequestModel {
  String? dateOfBirth;

  UpdateDateOfBirthRequestModel({this.dateOfBirth});

  UpdateDateOfBirthRequestModel.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}