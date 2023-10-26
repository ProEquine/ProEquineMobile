class AddSecondaryDisciplineRequestModel {
  int? disciplineId;
  String? nationalId;
  String? feiid;

  AddSecondaryDisciplineRequestModel(
      {this.disciplineId, this.nationalId, this.feiid});

  AddSecondaryDisciplineRequestModel.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];
    nationalId = json['nationalId'];
    feiid = json['feiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    data['nationalId'] = nationalId;
    data['feiid'] = feiid;
    return data;
  }
}