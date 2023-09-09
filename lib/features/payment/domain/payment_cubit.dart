import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:proequine/features/payment/presesntation/screens/payment_result_screen.dart';

import '../../../core/utils/Printer.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Map<String, dynamic>? paymentIntent;
  final String publishKey =
      'pk_test_51NSa7mDODWEiFzi38vQDnipoU2fgS9Y9gcT3NxIlvjY9gKwquAYVruTkDmh0EAYbhBvC9iGeLmii58HM1f9fR9sw00yL1LK9pP';
  final String secretKey =
      'sk_test_51NSa7mDODWEiFzi3SKZ2FZCgSMFd1tl1ttyQGywDP37oe91o6OgIp06uTx9HJqZk91CyWT0wSV5VT3LlMo96l4SG00OYiiHzZZ';

  displayPaymentSheet(BuildContext context, String tax, String totalAmount,
      String serviceFees,String? time, String? bookingId,String serviceType) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentResultScreen(
                      status: "Payment Successful",
                  totalPrice: totalAmount,
                  time: time,
                  refNo: bookingId,
                  serviceType: serviceType,
                    )));
      }).onError((error, stackTrace) {});
    } on StripeException catch (e) {
      print('StripeException Error is:---> $e');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentResultScreen(
                status: "Payment Failed",
                totalPrice: totalAmount,
                time: time,
                refNo: bookingId,
                serviceType: serviceType,

              )));
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment(String amount, BuildContext context, String tax,
      String totalAmount, String serviceFees,String? time,String? bookingId,String serviceType) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'AED', {
        "order_id": "12345",
        "customer_name": "John Doe",
        "priority": "high"
      });

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: 'Bsstah',
            billingDetails: const BillingDetails(
              name: 'Bahaa',
              phone: '0545049937',
              email: 'bahaa.soubh@gmail.com',
            ),
            allowsDelayedPaymentMethods: false,
            customerEphemeralKeySecret: paymentIntent!['ephemeralkey'],
            customerId: paymentIntent!['customer'],
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
          ))
          .then((value) {});
      if (context.mounted) {
        displayPaymentSheet(context, tax, totalAmount, serviceFees,time,bookingId,serviceType);
      }

      Print('client_secret ${paymentIntent!['client_secret']}');
    } catch (e, _) {
      Print(e);
    }
  }

  Future createPaymentIntent(String amount, String currency, metaData) async {
    emit(StripePaymentLoading());
    Print("In Price");
    final dio = Dio();

    try {
      Print("In Try");

      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          options: Options(headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }),
          queryParameters: {
            'amount': calculateAmount(amount),
            'currency': currency,
          });

      if (response.statusCode == 200) {
        Print(response.data);

        Print("Ram::::::::::::Success");
      } else {
        Print(response.data);
      }
      return response.data;
    } catch (e) {
      Print("In Try");
      emit(StripePaymentError(message: e.toString()));

      Print(e);
      Print("Ram::::::::::::False");
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
