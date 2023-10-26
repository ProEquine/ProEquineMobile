import '../../../core/CoreModels/base_result_model.dart';

class GetUserDisciplinesResponseModel extends BaseResultModel {
  List<Discipline>? disciplines;

  GetUserDisciplinesResponseModel({this.disciplines});

  GetUserDisciplinesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      disciplines = <Discipline>[];
      json['data'].forEach((v) {
        disciplines?.add(Discipline.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disciplines != null) {
      data['data'] = disciplines?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Discipline {
  int? personDisciplineId;
  String? disciplineTitle;
  String? disciplinePriority;
  String? feid;
  String? nationalId;

  Discipline(
      {this.personDisciplineId, this.disciplineTitle, this.disciplinePriority  ,this.feid,
        this.nationalId});

  Discipline.fromJson(Map<String, dynamic> json) {
    personDisciplineId = json['personDisciplineId'];
    disciplineTitle = json['disciplineTitle'];
    disciplinePriority = json['disciplinePriority'];
    feid = json['feid'];
    nationalId = json['nationalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personDisciplineId'] = personDisciplineId;
    data['disciplineTitle'] = disciplineTitle;
    data['disciplinePriority'] = disciplinePriority;
    data['feid'] = feid;
    data['nationalId'] = nationalId;
    return data;
  }
}
