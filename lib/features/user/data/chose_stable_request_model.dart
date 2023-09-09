class ChoseStableRequestModel {
  String? stableName;
  String? emirate;
  String? location;

  ChoseStableRequestModel({this.stableName, this.emirate, this.location});

  ChoseStableRequestModel.fromJson(Map<String, dynamic> json) {
    stableName = json['stableName'];
    emirate = json['emirate'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stableName'] = stableName;
    data['emirate'] = emirate;
    data['location'] = location;
    return data;
  }
}