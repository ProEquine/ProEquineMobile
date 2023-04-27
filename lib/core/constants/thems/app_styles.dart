import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors/app_colors.dart';

class AppStyles {
  /// Bold font

  static const TextStyle mainTextStyle = TextStyle(
    color: AppColors.mainTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 17.0,
  );
  static const TextStyle summaryTitleStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'notosan',
      fontWeight: FontWeight.w700,
      color: AppColors.white);
  static const TextStyle summaryDesStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'notosan',
      fontWeight: FontWeight.w400,
      color: Color(0xffA2A8AE));

  /// Medium Font

  static const TextStyle altTextStyle = TextStyle(
    color: AppColors.altTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  );

  /// Regular font

  static const mainFont = TextStyle(fontFamily: 'notosan');

  static const appbarTitleStyle = TextStyle(
    color: AppColors.mainTextColor,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  /// Registration flow title style

  static final registrationTitle = TextStyle(
    fontSize: 20.sp,
    fontFamily: "notosan",
    fontWeight: FontWeight.w500,
  );

  static final descriptions = TextStyle(
      color: AppColors.white,
      fontFamily: 'notosan',
      fontSize: 12.sp,
      fontWeight: FontWeight.w400);

  final mainTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? AppColors.white
              : AppColors.white,
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => mainFont,
        ),
      ),
    ),
    timePickerTheme: timePickerTheme,
    brightness: Brightness.dark,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.black,
    hintColor: AppColors.formsHintFont,
    fontFamily: 'notosan',

    // input fields globl style
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 17.sp,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(196, 134, 54, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      labelStyle: TextStyle(
        color: const Color.fromARGB(255, 237, 237, 237),
        fontSize: 17.sp,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
    ),
  );
  static final timePickerTheme = TimePickerThemeData(
    backgroundColor: AppColors.backgroundColor,
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodBorderSide: const BorderSide(color: AppColors.gold, width: 1),
    dayPeriodColor: AppColors.formsBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    dayPeriodTextColor: Colors.white,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: AppColors.gold, width: 1),
    ),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? AppColors.gold
            : AppColors.white),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? Colors.white
            : AppColors.gold),
    dialHandColor: AppColors.gold,
    dialBackgroundColor: Colors.blueGrey.shade800,
    hourMinuteTextStyle: const TextStyle(fontSize: 20, fontFamily: 'notosan'),
    dayPeriodTextStyle: const TextStyle(fontSize: 12, fontFamily: 'notosan'),
    helpTextStyle: const TextStyle(
        fontSize: 12, color: Colors.white, fontFamily: 'notosan'),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? AppColors.gold
            : Colors.white),
    entryModeIconColor: AppColors.gold,
  );
}
