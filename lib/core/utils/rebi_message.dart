import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

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
      description: Text(
        msg,
        style:
            TextStyle(color: Colors.white, fontFamily: 'notosan', fontSize: 16),
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,

      height: 60,
      width: 400,
      borderRadius: 12.0,
      iconType: IconType.cupertino,
      displayBorder: true,
      displaySideBar: false,
    ).show(context);
  }

  RebiMessage.error({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast(
      primaryColor: Colors.red.shade900,
      secondaryColor: Colors.white,
      backgroundType: BackgroundType.solid,
      icon: Icons.close,
      description: Text(
        msg,
        style:
            TextStyle(color: Colors.white, fontFamily: 'notosan', fontSize: 16),
      ),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.values[2],
      height: 55,
      width: 400,
      borderRadius: 12.0,
      displayBorder: true,
      displaySideBar: false,
    ).show(context);
  }

  RebiMessage.warning({
    required String msg,
    required BuildContext context,
  }) {
    MotionToast.warning(
      description: Text(msg),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      height: 60,
      width: 400,
      iconType: IconType.cupertino,
      borderRadius: 12.0,
      displayBorder: true,
      displaySideBar: false,
    ).show(context);
  }
}
