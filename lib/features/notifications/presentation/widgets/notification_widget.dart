import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class NotificationWidget extends StatelessWidget {
  String? bookingTypeText;
  String? time;
  String? id;
  String? title;
  String? date;
  String? transport;
  bool review;

  NotificationWidget(
      {super.key,
      this.review = false,
      this.bookingTypeText,
      this.date,
      this.id,
      this.time,
      this.transport,
      this.title,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
        color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? AppColors.formsBackground
            : AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            bookingTypeText == 'Booking completed'
                ? const Icon(
                    Icons.check,
                    color: Color(0xff34C759),
                  )
                : Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.yellow),
                  ),
            const SizedBox(
              width: 5,
            ),
            Text(
              bookingTypeText!,
              style: const TextStyle(
                fontFamily: 'notosan',

                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              id!,
              style: const TextStyle(
                fontFamily: 'notosan',

                color: AppColors.inboxContent,
              ),
            ),
            const Spacer(),
            Text(
              time!,
              style: const TextStyle(
                fontFamily: 'notosan',

                color: AppColors.inboxContent,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    title!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: AppColors.inboxContent,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  child: Text(
                    date!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.inboxContent,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  child: Text(
                    transport!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.inboxContent,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ]),
    );
  }
}
