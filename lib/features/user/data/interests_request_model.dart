class InterestsRequestModel {
  String? discipline;
  String? userType;
  int? personId;

  InterestsRequestModel({this.discipline, this.userType, this.personId});

  InterestsRequestModel.fromJson(Map<String, dynamic> json) {
    discipline = json['Discipline'];
    userType = json['UserType'];
    personId = json['PersonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Discipline'] = discipline;
    data['UserType'] = userType;
    data['PersonId'] = personId;
    return data;
  }
}