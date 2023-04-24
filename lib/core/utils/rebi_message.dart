import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      webBgColor: 'green',
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.SNACKBAR,
      webShowClose: true,
    );
  }

  RebiMessage.error({
    required String msg,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      webBgColor: 'red',
      timeInSecForIosWeb: 3,
      gravity: ToastGravity.SNACKBAR,
      webShowClose: true,
    );
  }

  RebiMessage.warning({
    required String msg,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: AppColors.gold,
      webBgColor: 'yellow',
      timeInSecForIosWeb: 3,
      textColor: Colors.black,
      gravity: ToastGravity.SNACKBAR,
      webShowClose: true,
    );
  }
}
