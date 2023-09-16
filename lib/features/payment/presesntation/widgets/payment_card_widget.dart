import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class PaymentCardWidget extends StatelessWidget {
  final String? bookingId;
  final String? date;
  final String status;
  final String? transportType;
  final String? from;
  final String? to;
  final int? horsesCount;
  final Function? onPressViewDetails;

  const PaymentCardWidget(
      {super.key,
      this.bookingId,
      this.transportType,
      this.date,
      this.from,
      this.to,
      this.horsesCount,
      this.onPressViewDetails,
      required this.status});

  @override
  Widget build(BuildContext context) {
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
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFF9500)),
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
                  bookingId!,
                  style: AppStyles.bookingContent,
                ),
                const Spacer(),

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
                      "${horsesCount.toString()} Horses",
                      style: AppStyles.bookingContent,
                    )
                  ],
                ),
                // Row(
                //   children: [
                //     Text(
                //       from!,
                //       style: AppStyles.bookingContent,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     SvgPicture.asset(
                //       AppIcons.directArrow,
                //       height: 20,
                //       width: 40,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       to!,
                //       style: AppStyles.bookingContent,
                //     ),
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    onPressViewDetails!();
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.yellow,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "View details",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.yellow,
                          fontSize: 12,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
