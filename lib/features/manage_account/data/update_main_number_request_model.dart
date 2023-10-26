class UpdateMainNumberRequestModel {
  String? phoneNumber;
  String? verificationCode;

  UpdateMainNumberRequestModel({this.phoneNumber, this.verificationCode});

  UpdateMainNumberRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['verificationCode'] = verificationCode;
    return data;
  }
}
