import 'package:flutter/material.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class InboxWidget extends StatelessWidget {
  final String? bookingId;
  final String? date;
  final String status;
  final String? transportType;
  final Function onTapPay;
  bool isTherePay;

  InboxWidget(
      {super.key,
      this.bookingId,
      this.transportType,
      this.date,
      required this.isTherePay,
      required this.onTapPay,
      required this.status});

  @override
  Widget build(BuildContext context) {
    int returnedColor() {
      if (status == 'Completed') {
        return 0xFF34C759;
      } else if (status == 'Payment pending') {
        return 0xFFFF9500;
      } else if (status == 'Responses') {
        return 0xFFFFCC00;
      }
      return 0xFFCC0000;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? const Color.fromRGBO(12, 12, 12, 1)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(returnedColor())),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? AppColors.white
                            : AppColors.backgroundColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  date!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  transportType!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 14,
                      width: 14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      bookingId.toString(),
                      style: AppStyles.bookingContent,
                    )
                  ],
                ),
                Spacer(),
                isTherePay
                    ? GestureDetector(
                        onTap: () {
                          onTapPay();
                        },
                        child: const Text(
                          "Pay",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.yellow,
                            fontSize: 12,
                            fontFamily: 'notosan',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
