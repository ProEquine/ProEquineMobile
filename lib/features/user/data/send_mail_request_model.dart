class SendMailVerificationRequestModel {
  String? email;

  SendMailVerificationRequestModel({this.email});

  SendMailVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    return data;
  }
}