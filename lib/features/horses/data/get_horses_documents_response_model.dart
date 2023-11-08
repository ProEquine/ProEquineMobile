import 'package:proequine/core/CoreModels/base_result_model.dart';

class AllHorsesDocumentsResponseModel extends BaseResultModel {
  List<HorseDocumentsList>? horseDocumentsList;

  AllHorsesDocumentsResponseModel({this.horseDocumentsList});

  AllHorsesDocumentsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['horseDocumentsList'] != null) {
      horseDocumentsList = <HorseDocumentsList>[];
      json['horseDocumentsList'].forEach((v) {
        horseDocumentsList!.add(HorseDocumentsList.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (horseDocumentsList != null) {
      data['horseDocumentsList'] =
          horseDocumentsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HorseDocumentsList {
  String? docNumber;
  String? docTitle;
  String? docCategory;
  String? docType;
  String? docRegistrationDate;
  String? docExpiryDate;
  String? docNotes;
  int? docId;
  String? docLink;

  HorseDocumentsList(
      {this.docNumber,
        this.docTitle,
        this.docCategory,
        this.docType,
        this.docRegistrationDate,
        this.docExpiryDate,
        this.docNotes,
        this.docId,
        this.docLink});

  HorseDocumentsList.fromJson(Map<String, dynamic> json) {
    docNumber = json['docNumber'];
    docTitle = json['docTitle'];
    docCategory = json['docCategory'];
    docType = json['docType'];
    docRegistrationDate = json['docRegistrationDate'];
    docExpiryDate = json['docExpiryDate'];
    docNotes = json['docNotes'];
    docId = json['docId'];
    docLink = json['docLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docNumber'] = docNumber;
    data['docTitle'] = docTitle;
    data['docCategory'] = docCategory;
    data['docType'] = docType;
    data['docRegistrationDate'] = docRegistrationDate;
    data['docExpiryDate'] = docExpiryDate;
    data['docNotes'] = docNotes;
    data['docId'] = docId;
    data['docLink'] = docLink;
    return data;
  }
}