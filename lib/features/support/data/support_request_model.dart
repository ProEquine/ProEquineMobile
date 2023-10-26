class CreateSupportRequestModel {
  String? referenceNumber;
  String? subject;
  String? division;
  String? inquiry;

  CreateSupportRequestModel(
      {this.referenceNumber, this.subject, this.division, this.inquiry});

  CreateSupportRequestModel.fromJson(Map<String, dynamic> json) {
    referenceNumber = json['referenceNumber'];
    subject = json['subject'];
    division = json['division'];
    inquiry = json['inquiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referenceNumber'] = referenceNumber;
    data['subject'] = subject;
    data['division'] = division;
    data['inquiry'] = inquiry;
    return data;
  }
}