class CheckVerificationRequestModel {
  String? phoneNumber;
  String? code;

  CheckVerificationRequestModel({this.phoneNumber, this.code});

  CheckVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['code'] = code;
    return data;
  }
}