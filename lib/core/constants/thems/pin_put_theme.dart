import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../colors/app_colors.dart';

class PinThemeConst {
  static final defaultPinTheme = PinTheme(
    width: 35,
    height: 52,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp, color: AppColors.white, fontWeight: FontWeight.w600),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 8.0,
          color: Color(0xff555D68),
        ),
      ),
      color: AppColors.formsBackground,
    ),
  );

  static final focusedPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp, color: AppColors.white, fontWeight: FontWeight.w600),
    decoration: const BoxDecoration(
      border: Border(
        left: BorderSide(
            width: 2.0,
            color: AppColors.gold
        ),
        top: BorderSide(
            width: 2.0,
            color: AppColors.gold
        ),
        right: BorderSide(
            width: 2.0,
            color: AppColors.gold
        ),
        bottom: BorderSide(
          width: 8.0,
          color: AppColors.gold
        ),
      ),
      color: AppColors.formsBackground,
    ),
  );

  static final submittedPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp, color: AppColors.white, fontWeight: FontWeight.w600),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 8.0,
            color: AppColors.gold
        ),
      ),
      color: AppColors.formsBackground,
    ),
  );

}
