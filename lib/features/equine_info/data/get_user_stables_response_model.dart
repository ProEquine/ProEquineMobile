import '../../../core/CoreModels/base_result_model.dart';

class GetUserStablesResponseModel extends BaseResultModel {
  List<UserStables>? stables;

  GetUserStablesResponseModel({this.stables});

  GetUserStablesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      stables = <UserStables>[];
      json['data'].forEach((v) {
        stables?.add(UserStables.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stables != null) {
      data['data'] = stables?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class UserStables {
  int? personStableId;
  String? stableName;
  String? entryType;
  String? stablePriority;
  int? stableId;
  String? stableCountry;
  String? stableState;

  UserStables(
      {this.personStableId,
        this.stableName,
        this.entryType,
        this.stablePriority,
        this.stableCountry,
        this.stableState,
        this.stableId});

  UserStables.fromJson(Map<String, dynamic> json) {
    personStableId = json['personStableId'];
    stableName = json['stableName'];
    entryType = json['entryType'];
    stablePriority = json['stablePriority'];
    stableCountry = json['stableCountry'];
    stableState = json['stableState'];
    stableId = json['stableId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personStableId'] = personStableId;
    data['stableName'] = stableName;
    data['entryType'] = entryType;
    data['stablePriority'] = stablePriority;
    data['stableCountry'] = stableCountry;
    data['stableState'] = stableState;
    data['stableId'] = stableId;
    return data;
  }
}