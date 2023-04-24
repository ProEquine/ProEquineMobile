import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../colors/app_colors.dart';

class PinThemeConst {
  static final defaultPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w600),
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

  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.white),


  );

  static final submittedPinTheme = PinTheme(
    width: 48,
    height: 63,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    textStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.white),
    ),
  );
}
