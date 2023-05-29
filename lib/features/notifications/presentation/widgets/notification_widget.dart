import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import 'package:sizer/sizer.dart';

class NotificationWidget extends StatelessWidget {
  String? statusImage;
  String? bookingTypeText;
  String? image;
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
      this.image,
      this.statusImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(25, 25, 25, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            SvgPicture.asset(statusImage!),
            const SizedBox(
              width: 5,
            ),
            Text(
              bookingTypeText!,
              style: const TextStyle(
                color: AppColors.textColor,
                fontFamily: 'notosan',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              id!,
              style: const TextStyle(
                color: AppColors.grey,
                fontFamily: 'notosan',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              time!,
              style: const TextStyle(
                color: AppColors.grey,
                fontFamily: 'notosan',
                fontSize: 12,
                fontWeight: FontWeight.w700,
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
                  width: 30.0.w,
                  child: Text(
                    title!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 14,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: 30.0.w,
                  child: Text(
                    date!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.formsHintFont,
                        fontSize: 12,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: 30.0.w,
                  child: Text(
                    transport!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.formsHintFont,
                        fontSize: 12,
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
            Container(
              height: 9.0.h,
              width: 25.0.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
