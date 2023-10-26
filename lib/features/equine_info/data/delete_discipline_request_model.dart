class DeleteDisciplineResponseModel {
  int? personDisciplineId;

  DeleteDisciplineResponseModel({this.personDisciplineId});

  DeleteDisciplineResponseModel.fromJson(Map<String, dynamic> json) {
    personDisciplineId = json['personDisciplineId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personDisciplineId'] = personDisciplineId;
    return data;
  }
}