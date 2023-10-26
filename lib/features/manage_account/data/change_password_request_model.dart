class UpdatePasswordRequestModel {
  String? currentPassword;
  String? newPassword;

  UpdatePasswordRequestModel({this.currentPassword, this.newPassword});

  UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}