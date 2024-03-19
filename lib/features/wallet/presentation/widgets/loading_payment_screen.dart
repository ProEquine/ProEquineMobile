import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../screens/success_payment_screen.dart';

class LoadingPaymentScreen extends StatefulWidget {
  final String orderId;
  final String paymentTime;
  final String paymentAmount;

  const LoadingPaymentScreen(
      {Key? key,
        required this.orderId,
        required this.paymentTime,
        required this.paymentAmount})
      : super(key: key);

  @override
  State<LoadingPaymentScreen> createState() => _LoadingPaymentScreenState();
}

class _LoadingPaymentScreenState extends State<LoadingPaymentScreen> {
  late Timer timer;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the next page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => SuccessPaymentScreen(
                refNumber: widget.orderId,
                paymentTime: widget.paymentTime,
                paymentAmount: widget.paymentAmount)),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadingCircularWidget()
        ],
      ),
    );
  }
}
