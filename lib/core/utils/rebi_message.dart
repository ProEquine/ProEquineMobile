import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:proequine/toasticons_icons.dart';

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
            const TextStyle(color: Colors.white, fontFamily: 'notosan', fontSize: 16),
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
      description: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            const Icon(
              ToastIcons.cancelCircled,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                msg,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'notosan',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      primaryColor: Colors.red.shade900,
      secondaryColor: Colors.white,
      backgroundType: BackgroundType.solid,
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.values[2],
      height: 55,
      width: 400,
      borderRadius: 12.0,
      displayBorder: false,
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
