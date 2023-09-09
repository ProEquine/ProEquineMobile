import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import '../constants/icons_files/toast_icons.dart';

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
    MotionToast(
      description: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Success!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.statusText,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'notosan',
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    msg,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.statusText,
                      fontFamily: 'notosan',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: const Offset(10.0, 8),
                child: const Icon(
                  Icons.close,
                  color: AppColors.statusText,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      primaryColor: AppColors.successToast,
      secondaryColor: AppColors.statusText,
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.values[2],
      height: 70,
      width: 350,
      borderRadius: 8.0,
      displayBorder: true,
      displaySideBar: false,
      animationCurve: Curves.linear,
    ).show(context);
  }

  RebiMessage.error({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast(
      description: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Error",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'notosan',
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    msg,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontFamily: 'notosan',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: const Offset(10.0, 3),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      primaryColor: AppColors.errorToast,
      secondaryColor: AppColors.red,
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.values[2],
      height: 70,
      width: 350,
      borderRadius: 8.0,
      displayBorder: true,
      displaySideBar: false,
      animationCurve: Curves.linear,
    ).show(context);
  }

  RebiMessage.warning({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast(
      description: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Warning!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.unVerifiedText,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'notosan',
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    msg,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.unVerifiedText,
                      fontFamily: 'notosan',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Transform.translate(
                offset: const Offset(10.0, 8),
                child: const Icon(
                  Icons.close,
                  color: AppColors.unVerifiedText,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      primaryColor: AppColors.unVerifiedContainer,
      secondaryColor: AppColors.unVerifiedText,
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.values[2],
      height: 70,
      width: 350,
      borderRadius: 8.0,
      displayBorder: true,
      displaySideBar: false,
      animationCurve: Curves.linear,
    ).show(context);
  }
}
