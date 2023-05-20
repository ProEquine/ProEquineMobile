class UpdateMailRequestModel {
  String? previousEmail;
  String? newEmail;

  UpdateMailRequestModel({this.previousEmail, this.newEmail});

  UpdateMailRequestModel.fromJson(Map<String, dynamic> json) {
    previousEmail = json['previousEmail'];
    newEmail = json['newEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['previousEmail'] = previousEmail;
    data['newEmail'] = newEmail;
    return data;
  }
}