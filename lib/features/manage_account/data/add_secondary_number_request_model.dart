class AddSecondaryNumberRequestModel {
  String? personPhoneNumber;
  int? personId;

  AddSecondaryNumberRequestModel({this.personPhoneNumber, this.personId});

  AddSecondaryNumberRequestModel.fromJson(Map<String, dynamic> json) {
    personPhoneNumber = json['personPhoneNumber'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personPhoneNumber'] = personPhoneNumber;
    data['personId'] = personId;
    return data;
  }
}