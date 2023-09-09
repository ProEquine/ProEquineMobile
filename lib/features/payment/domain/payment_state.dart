part of 'payment_cubit.dart';


abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class StripePaymentSuccessfully extends PaymentState {
  final String? message;

  StripePaymentSuccessfully({required this.message});
}

class StripePaymentLoading extends PaymentState {}

class StripePaymentError extends PaymentState {
  final String? message;

  StripePaymentError({required this.message});
}