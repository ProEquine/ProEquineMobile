import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ShippingWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onTap;

  const ShippingWidget({super.key, this.image, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 22.75.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              image!,
              width: 41.16.w,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title!,
            textAlign: TextAlign.start,
            style: const TextStyle(

                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
