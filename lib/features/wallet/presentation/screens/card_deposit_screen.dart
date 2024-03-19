import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/wallet/presentation/screens/deposit_summary_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';

import '../../../../core/widgets/rebi_button.dart';
import '../../domain/wallet_cubit.dart';

class CardDepositScreen extends StatefulWidget {
  final String type;

  const CardDepositScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<CardDepositScreen> createState() => _CardDepositScreenState();
}

class _CardDepositScreenState extends State<CardDepositScreen> {
  WalletCubit cubit = WalletCubit();

  bool unActive = false;
  TextEditingController controller = TextEditingController(text: '');

  void _addValueToInput(int value) {
    if (controller.text.isNotEmpty) {
      try {
        int inputValue = int.parse(controller.text);
        int newValue = inputValue + value;
        setState(() {
          controller.text = newValue.toString();
        });
      } catch (e) {
        // Handle parsing error
      }
    } else if (controller.text.isEmpty) {
      setState(() {
        controller.text = value.toString();
      });
    }
  }



  String get lessThanInputText {
    if (controller.text.isNotEmpty) {
      try {
        int inputValue = int.parse(controller.text);
        double lessValue =
            inputValue * (1 - 0.039) - 1; // 2.9% less than the input plus 1 AED
        return '≈ ${lessValue.toStringAsFixed(2)}';
      } catch (e) {
        return 'Invalid Input'.tra;
      }
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Card Deposit".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: true,
            child: Container(
              height: 175,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFDFD9C9)),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Amount to deposit',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w600,
                      height: 0.22,
                      letterSpacing: 0.18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.gold,
                    style: const TextStyle(
                      color: Color(0xFFC48636),
                      fontSize: 34.06,
                      fontFamily: 'notosans',
                      fontWeight: FontWeight.w700,
                    ),
                    controller: controller,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // contentPadding: EdgeInsets.only(left: 40.w),
                      hintText: '0.0 AED',
                      hintStyle: TextStyle(
                        fontSize: 34.06,
                        fontFamily: 'notosans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => _addValueToInput(250),
                        child: Container(
                          width: 95,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Color(0xFFEBEEF4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "+ 250",
                              style: TextStyle(
                                  color: AppColors.blackLight,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _addValueToInput(500),
                        child: Container(
                          width: 95,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Color(0xFFEBEEF4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "+ 500",
                              style: TextStyle(
                                  color: AppColors.blackLight,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _addValueToInput(1000),
                        child: Container(
                          width: 95,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Color(0xFFEBEEF4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "+ 1000",
                              style: TextStyle(
                                  color: AppColors.blackLight,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          widget.type == 'Card'
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: RebiButton(
                      onPressed: () {
                        int totalAmount=int.parse(controller.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DepositSummaryScreen(
                                    totalAmount: totalAmount.toString(),
                                    serviceFee: '2.9% + 1% +1 AED',
                                    amount: lessThanInputText)));
                      },
                      child: Text("Next".tra)))
              : Container(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

// onPressCharge(String amount, BuildContext context) async {
//   await cubit.makePayment(amount, context, '${10}',
//       '${int.parse(widget.totalAmount)}', widget.totalAmount);
// }
}
