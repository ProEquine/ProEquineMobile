import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class EventComingSoon extends StatelessWidget {
  const EventComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Background image
            SizedBox(
              height: 116.0,
              width: 27.2.w,
              child: Image.asset(
                AppImages.event,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Container(color: Colors.black),
              ),
            ),
            // Text widget
            const Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Coming soon',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Event",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColors.textColor,
              fontFamily: 'notosan',
              fontWeight: FontWeight.w400,
              fontSize: 15.0),
        )
      ],
    );
  }
}
