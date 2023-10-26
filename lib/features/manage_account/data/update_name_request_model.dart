class UpdateNameRequestModel {
  String? firstName;
  String? middleName;
  String? lastName;

  UpdateNameRequestModel({this.firstName, this.middleName, this.lastName});

  UpdateNameRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    return data;
  }
}