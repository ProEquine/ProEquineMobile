class UpdateSecondaryNumberRequestModel {
  String? phoneNumberType;
  String? oldSecondaryNumber;
  String? newSecondaryNumber;

  UpdateSecondaryNumberRequestModel(
      {this.phoneNumberType, this.oldSecondaryNumber, this.newSecondaryNumber});

  UpdateSecondaryNumberRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumberType = json['phoneNumberType'];
    oldSecondaryNumber = json['oldSecondaryNumber'];
    newSecondaryNumber = json['newSecondaryNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumberType'] = phoneNumberType;
    data['oldSecondaryNumber'] = oldSecondaryNumber;
    data['newSecondaryNumber'] = newSecondaryNumber;
    return data;
  }
}