class EditPhoneRequestModel {
  String? newPhoneNumber;

  EditPhoneRequestModel({this.newPhoneNumber});

  EditPhoneRequestModel.fromJson(Map<String, dynamic> json) {
    newPhoneNumber = json['newPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newPhoneNumber'] = newPhoneNumber;
    return data;
  }
}