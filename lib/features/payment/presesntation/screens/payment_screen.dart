import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/notifications/data/booking_details_response_model.dart';
import 'package:proequine/features/payment/presesntation/screens/test_apple_pay_result.dart';
import 'package:proequine/features/payment/presesntation/widgets/payment_card_widget.dart';
import 'package:proequine/features/payment/presesntation/widgets/payment_details_bottom_sheet.dart';
import 'package:proequine/features/payment/presesntation/widgets/payment_summary_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../domain/payment_cubit.dart';

import 'package:proequine/payment_config.dart' as payment_configuration;

class PaymentScreen extends StatefulWidget {
  BookingDetailsResponseModel bookingDetailsResponseModel;

  PaymentScreen({Key? key, required this.bookingDetailsResponseModel})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? paymentMethod = 'null';
  String? selectedValue;

  // String? appleValue = 'ApplePay';
  String? creditValue = 'Credit';
  PaymentCubit cubit = PaymentCubit();
  bool isLoading = false;

  // bool isApplePayAvailable = true;

  // void onApplePayResult(paymentResult) {
  //   debugPrint(paymentResult.toString());
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => TestApplePayResult(
  //                 status: paymentResult.toString(),
  //               )));
  // }

  // late Pay _payClient;

  @override
  void initState() {
    super.initState();
    selectedValue = 'Credit';

    // _payClient = Pay({
    //   PayProvider.apple_pay: PaymentConfiguration.fromJsonString(
    //       payment_configuration.defaultApplePay),
    // });
    // _checkIfApplePayInstalled();
  }

  // Future<void> _checkIfApplePayInstalled() async {
  //   var hasApplePay = await _payClient.userCanPay(PayProvider.apple_pay);
  //
  //   if (hasApplePay) {
  //     setState(() {
  //       // Write here your code..
  //     });
  //     Print('Apple Pay is available on this device!');
  //   } else {
  //     isApplePayAvailable = false;
  //     Print('Apple Pay is not available on this device!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    // var _paymentItems = [
    //   PaymentItem(
    //     label: 'Total for ${widget.bookingDetailsResponseModel.bookingId}',
    //     amount: widget.bookingDetailsResponseModel.total,
    //     status: PaymentItemStatus.final_price,
    //   )
    // ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Payment",
          isThereBackButton: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            PaymentCardWidget(
              status: widget.bookingDetailsResponseModel.tripStatus,
              bookingId: widget.bookingDetailsResponseModel.bookingId,
              transportType: widget.bookingDetailsResponseModel.tripType,
              date: widget.bookingDetailsResponseModel.pickupDate,
              from: widget.bookingDetailsResponseModel.pickupLocation,
              to: widget.bookingDetailsResponseModel.dropLocation,
              horsesCount:
                  int.parse(widget.bookingDetailsResponseModel.horsesNumber),
              onPressViewDetails: () {
                paymentDetailsBottomSheet(
                  context: context,
                  title: "Trip details",
                  pickUpDate: widget.bookingDetailsResponseModel.pickupDate,
                  pickUpTime: widget.bookingDetailsResponseModel.pickupTime,
                  tripType: widget.bookingDetailsResponseModel.tripType,
                  pickupLocation:
                      widget.bookingDetailsResponseModel.pickupLocation,
                  pickupContactNumber:
                      widget.bookingDetailsResponseModel.pickupContactNumber,
                  pickupContactName:
                      widget.bookingDetailsResponseModel.pickupContactName,
                  dropLocation: widget.bookingDetailsResponseModel.dropLocation,
                  dropContactName:
                      widget.bookingDetailsResponseModel.dropContactName,
                  dropContactNumber:
                      widget.bookingDetailsResponseModel.dropContactNumber,
                  horsesNumber: widget.bookingDetailsResponseModel.horsesNumber,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Payment Summary",
              style: AppStyles.profileBlackTitles,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            PaymentSummaryWidget(
                subtotal: widget.bookingDetailsResponseModel.subtotal,
                tax: widget.bookingDetailsResponseModel.tax,
                total: widget.bookingDetailsResponseModel.total),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Payment Method",
              style: AppStyles.profileBlackTitles,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: kPadding,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.50, color: AppColors.backgroundColorLight),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      activeColor: AppColors.yellow,
                      toggleable: true,
                      value: creditValue,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                          paymentMethod = selectedValue ?? 'null';
                        });
                      },
                    ),
                    SvgPicture.asset(AppIcons.creditCard),
                    const Text(
                      '  Debit / Credit Card',
                      style: TextStyle(
                        color: AppColors.blackLight,
                        fontSize: 14,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 5,
            //       horizontal: kPadding,
            //     ),
            //     clipBehavior: Clip.antiAlias,
            //     decoration: ShapeDecoration(
            //       color: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         side: const BorderSide(
            //             width: 0.50, color: AppColors.backgroundColorLight),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Radio(
            //           activeColor: AppColors.yellow,
            //           toggleable: true,
            //           value: appleValue,
            //           groupValue: selectedValue,
            //           onChanged: (value) {
            //             setState(() {
            //               selectedValue = value;
            //               if (value == 'ApplePay') {
            //                 if (isApplePayAvailable) {
            //                   paymentMethod = selectedValue ?? 'null';
            //                 } else {
            //                   paymentMethod = 'null';
            //                   RebiMessage.error(
            //                       msg:
            //                           "Apple Pay is not available on this device!",
            //                       context: context);
            //                 }
            //               } else {
            //                 paymentMethod = selectedValue ?? 'null';
            //               }
            //
            //               Print("Selected value $selectedValue");
            //               Print("value $value");
            //               Print("payment method is $paymentMethod");
            //             });
            //           },
            //         ),
            //         SvgPicture.asset(AppIcons.applePay),
            //         const SizedBox()
            //       ],
            //     ),
            //   ),
            // ),
            const Spacer(),
            const Center(
              child: Text(
                'Invoice will be sent to your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.formsHintFontLight,
                  fontSize: 14,
                  fontFamily: 'notosan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<PaymentCubit, PaymentState>(
              bloc: cubit,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return isLoading?const LoadingCircularWidget():RebiButton(

                    backgroundColor: selectedValue != 'Credit'
                        ? AppColors.formsLabel
                        : AppColors.yellow,
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });

                      // Print("method from main $paymentMethod");
                      if (selectedValue == 'ApplePay' ||
                          selectedValue != 'Credit') {
                      } else {
                        onPressPayStripe(
                            widget.bookingDetailsResponseModel.total, context);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                        "Pay ${widget.bookingDetailsResponseModel.total} AED"));
              },
            ),
            // : paymentMethod == 'ApplePay'
            //     ? ApplePayButton(
            //         height: 50,
            //         width: double.infinity,
            //         paymentConfiguration:
            //             PaymentConfiguration.fromJsonString(
            //                 payment_configuration.defaultApplePay),
            //         paymentItems: _paymentItems,
            //         style: ApplePayButtonStyle.automatic,
            //         // type: ApplePayButtonType.checkout,
            //
            //         margin: const EdgeInsets.only(top: 10.0),
            //         onPaymentResult: onApplePayResult,
            //         loadingIndicator: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       )
            //     : const SizedBox(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  onPressPayStripe(String amount, BuildContext context) async {
    await cubit.makePayment(
      amount,
      context,
      '${int.parse(widget.bookingDetailsResponseModel.tax)}',
      '${int.parse(widget.bookingDetailsResponseModel.total)}',
      widget.bookingDetailsResponseModel.total,
      '${widget.bookingDetailsResponseModel.pickupDate} . ${widget.bookingDetailsResponseModel.pickupTime}',
      widget.bookingDetailsResponseModel.bookingId,
      widget.bookingDetailsResponseModel.tripType,
    );
  }
}
