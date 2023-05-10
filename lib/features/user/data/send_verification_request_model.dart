class SendVerificationRequestModel {
  String? phoneNumber;
  String? channel;

  SendVerificationRequestModel({this.phoneNumber, this.channel});

  SendVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['channel'] = channel;
    return data;
  }
}