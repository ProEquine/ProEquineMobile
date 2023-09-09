import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class PaymentSummaryWidget extends StatelessWidget {
  final String subtotal;
  final String tax;
  final String total;
  const PaymentSummaryWidget({Key? key, required this.subtotal, required this.tax, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Subtotal ',
              style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              subtotal,
              style: const TextStyle(
                color: AppColors.blackLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            const Text(
              'Tax ',
              style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              tax,
              style: const TextStyle(
                color: AppColors.blackLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            const Text(
              'Total ',
              style: TextStyle(
                color: AppColors.blackLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              total,
              style: const TextStyle(
                color: AppColors.blackLight,
                fontSize: 14,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
