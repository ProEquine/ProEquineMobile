import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';

class RebiMessage {
  RebiMessage({
    required String msg,
    Color bgColor = Colors.green,
    Color? textColor,
    String webBgColor = 'green',
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: bgColor,
      webBgColor: webBgColor,
      textColor: textColor,
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.SNACKBAR,
      webShowClose: true,
    );
  }

  RebiMessage.success({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast.success(
  description: Text(msg),
      animationType: AnimationType.fromTop,

    ).show(context);
  }

  RebiMessage.error({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast.error(
      // primaryColor: AppColors.red,
      // secondaryColor: AppColors.red,
      description: Text(msg),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      height: 60,
      width: 350,
      borderRadius: 12.0,
      displayBorder: true,
      displaySideBar: true,




    ).show(context);
  }

  RebiMessage.warning({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast.warning(
      description: Text(msg),
      animationType: AnimationType.fromTop,
    ).show(context);
  }
}
