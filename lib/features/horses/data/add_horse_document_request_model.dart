class AddHorseDocumentRequestModel {
  String? docNumber;
  String? docTitle;
  String? docType;
  String? docCategory;
  String? docRegistrationDate;
  String? docExpiryDate;
  int? horseId;
  String? docNotes;

  AddHorseDocumentRequestModel(
      {this.docNumber,
        this.docTitle,
        this.docCategory,
        this.docExpiryDate,
        this.docNotes,
        this.docRegistrationDate,
        this.docType,
        this.horseId,});

  AddHorseDocumentRequestModel.fromJson(Map<String, dynamic> json) {
    docNumber = json['DocNumber'];
    docType = json['DocType'];
    docRegistrationDate = json['DocRegistrationDate'];
    docTitle = json['DocTitle'];
    docNotes = json['DocNotes'];
    docExpiryDate = json['DocExpiryDate'];
    docCategory = json['DocCategory'];
    horseId = json['HorseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DocNumber'] = docNumber;
    data['DocType'] = docType;
    data['DocRegistrationDate'] = docRegistrationDate;
    data['DocTitle'] = docTitle;
    data['DocNotes'] = docNotes;
    data['DocExpiryDate'] = docExpiryDate;
    data['DocCategory'] = docCategory;
    data['HorseId'] = horseId;
    return data;
  }
}