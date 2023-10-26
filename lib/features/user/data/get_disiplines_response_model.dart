import '../../../core/CoreModels/base_result_model.dart';

class GetAllDisciplinesResponseModel extends BaseResultModel {
  List<AllDiscipline>? data;

  GetAllDisciplinesResponseModel({this.data});

  GetAllDisciplinesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllDiscipline>[];
      json['data'].forEach((v) {
        data?.add(AllDiscipline.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AllDiscipline {
  int? disciplineId;
  String? disciplineTitle;

  AllDiscipline({this.disciplineId, this.disciplineTitle});

  AllDiscipline.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];
    disciplineTitle = json['disciplineTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    data['disciplineTitle'] = disciplineTitle;
    return data;
  }
}