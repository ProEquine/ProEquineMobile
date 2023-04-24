import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ShippingWidget extends StatelessWidget {
  String? image;
  String? title;
  Function? onTap;

  ShippingWidget({this.image, this.title, this.onTap});

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
            height: 177.0,
            width: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(image!),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title!,
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: AppColors.white,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
