class HorseVerificationRequestModel {
  int? id;
  String? horseProofOwnership;
  String? horseNationalPassport;
  String? horseFEIPassport;

  HorseVerificationRequestModel(
      {this.id,
        this.horseProofOwnership,
        this.horseNationalPassport,
        this.horseFEIPassport});

  HorseVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horseProofOwnership = json['horseProofOwnership'];
    horseNationalPassport = json['horseNationalPassport'];
    horseFEIPassport = json['horseFEIPassport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['horseProofOwnership'] = horseProofOwnership;
    data['horseNationalPassport'] = horseNationalPassport;
    data['horseFEIPassport'] = horseFEIPassport;
    return data;
  }
}