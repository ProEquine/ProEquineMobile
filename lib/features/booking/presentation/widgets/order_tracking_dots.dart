import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:sizer/sizer.dart';

class OrderTrackingDots extends StatelessWidget {
  final bool isPassed;

  const OrderTrackingDots({
    Key? key,
    this.isPassed = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
              left: 11.0.w,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 3,
            color: isPassed ? Colors.green : AppColors.grey,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 3,
            color: isPassed ? Colors.green : AppColors.grey,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 3,
            color: isPassed ? Colors.green : AppColors.grey,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 3,
            color: isPassed ? Colors.green : AppColors.grey,
          ),
        ],
      ),
    );
  }
}
