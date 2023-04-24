import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class LoadingCircularWidget extends StatelessWidget {
  bool isLogout = false;

  LoadingCircularWidget({this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: isLogout ? const Color(0xFFc43221) : AppColors.white,
        valueColor: isLogout
            ? AlwaysStoppedAnimation<Color>(
                const Color(0xFFc43221).withOpacity(0.06))
            : const AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }
}
