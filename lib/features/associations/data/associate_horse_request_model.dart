class AssociateHorseRequestModel {
  int? horseId;
  String? userName;
  String? type;

  AssociateHorseRequestModel({ this.horseId, this.userName, this.type});

  AssociateHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    userName = json['userName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['userName'] = userName;
    data['type'] = type;
    return data;
  }
}
