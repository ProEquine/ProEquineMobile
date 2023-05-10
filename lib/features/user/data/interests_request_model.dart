class InterestsRequestModel {
  String? interest;
  String? type;
  String? phoneNumber;

  InterestsRequestModel({this.interest, this.type, this.phoneNumber});

  InterestsRequestModel.fromJson(Map<String, dynamic> json) {
    interest = json['interest'];
    type = json['type'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['interest'] = interest;
    data['type'] = type;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}