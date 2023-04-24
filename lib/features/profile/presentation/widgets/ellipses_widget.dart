import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

class EllipsesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 3,left: 3,top: 12),
          height: 5.0,
        width: 5.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightGrey,
        ),),
        Container(height: 5.0,
          margin: const EdgeInsets.only(right: 3,left: 3,top: 12),
          width: 5.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGrey,
          ),),
        Container(height: 5.0,
          width: 5.0,
          margin: const EdgeInsets.only(right: 3,left: 3,top: 12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGrey,
          ),),
      ],
    );
  }
}
