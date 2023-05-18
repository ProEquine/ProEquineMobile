class SupportRequestModel {
  String? referenceNumber;
  String? description;
  String? phoneNumber;

  SupportRequestModel(
      {this.referenceNumber, this.description, this.phoneNumber});

  SupportRequestModel.fromJson(Map<String, dynamic> json) {
    referenceNumber = json['referenceNumber'];
    description = json['description'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceNumber'] = referenceNumber;
    data['description'] = description;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}