import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';


_showDatePicker(BuildContext context,Function setValue) {
  showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.gold, // <-- SEE HERE
                onPrimary: AppColors.white, // <-- SEE HERE
                onSurface: Colors.white, // <-- SEE HERE
              ),
              dialogTheme: const DialogTheme(
                backgroundColor: AppColors.formsBackground,
                contentTextStyle: TextStyle(fontFamily: 'notosan'),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.white, // button text color
                ),
              ),
            ),
            child: Container(
              height: 100,
              width: 100,
              child: child!,
            ));
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025))
      .then((value) {
 setValue(value);
  });
}

bool showDate(context,Function setValue){

_showDatePicker(context, setValue);
return true;
}