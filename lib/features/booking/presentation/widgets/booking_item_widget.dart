import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class BookingItemWidget extends StatelessWidget {
  final String? bookingId;
  final String? date;
  final String status;
  final String? transportType;
  final String? from;
  final String? to;
  final int? horsesCount;

  const BookingItemWidget(
      {super.key,
      this.bookingId,
      this.transportType,
      this.date,
      this.from,
      this.to,
      this.horsesCount,
      required this.status});

  @override
  Widget build(BuildContext context) {
    int returnedColor() {
      if (status == 'Confirmed') {
        return 0xFF007AFF;
      } else if (status == 'Pending') {
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
                Row(
                  children: [
                    Text(
                      from!,
                      style: AppStyles.bookingContent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      AppIcons.directArrow,
                      height: 20,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      to!,
                      style: AppStyles.bookingContent,
                    ),
                  ],
                ),
                Text(
                  bookingId!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
