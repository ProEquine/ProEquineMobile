import 'package:proequine/core/CoreModels/base_result_model.dart';

class PaymentDetailsResponseModel extends BaseResultModel{
  String? id;
  String? time;
  num? amount;
  num? fees;
  num? depositAmount;
  num? newWalletAmount;

  PaymentDetailsResponseModel(
      {this.id,
        this.time,
        this.amount,
        this.fees,
        this.depositAmount,
        this.newWalletAmount});

  PaymentDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    amount = json['amount'];
    fees = json['fees'];
    depositAmount = json['depositAmount'];
    newWalletAmount = json['newWalletAmount'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    data['amount'] = amount;
    data['fees'] = fees;
    data['depositAmount'] = depositAmount;
    data['newWalletAmount'] = newWalletAmount;
    return data;
  }
}