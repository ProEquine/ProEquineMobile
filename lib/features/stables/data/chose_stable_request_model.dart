class ChoseMainStableRequestModel {
  int? id;
  String? name;
  String? emirate;
  String? pinLocation;

  ChoseMainStableRequestModel(
      {this.id, this.name, this.emirate, this.pinLocation});

  ChoseMainStableRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    return data;
  }
}
