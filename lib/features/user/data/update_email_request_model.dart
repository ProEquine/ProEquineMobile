class UpdateMailRequestModel {
  String? newEmail;

  UpdateMailRequestModel({this.newEmail});

  UpdateMailRequestModel.fromJson(Map<String, dynamic> json) {
    newEmail = json['newEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newEmail'] = newEmail;
    return data;
  }
}