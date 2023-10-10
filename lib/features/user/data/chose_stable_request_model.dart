class ChoseStableRequestModel {
  int? stableId;
  String? stableName;
  bool? isNewStable;
  String? emirate;
  String? location;
  int? personId;

  ChoseStableRequestModel(
      {this.stableId,
        this.stableName,
        this.isNewStable,
        this.emirate,
        this.location,
        this.personId});

  ChoseStableRequestModel.fromJson(Map<String, dynamic> json) {
    stableId = json['stableId'];
    stableName = json['stableName'];
    isNewStable = json['isNewStable'];
    emirate = json['emirate'];
    location = json['location'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stableId'] = stableId;
    data['stableName'] = stableName;
    data['isNewStable'] = isNewStable;
    data['emirate'] = emirate;
    data['location'] = location;
    data['personId'] = personId;
    return data;
  }
}