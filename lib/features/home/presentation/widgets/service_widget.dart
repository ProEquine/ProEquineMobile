import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:sizer/sizer.dart';

class ServiceWidget extends StatelessWidget {
  String? image;
  String? title;
  Function? onTap;

  ServiceWidget({this.image, this.title, this.onTap});

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
            height: 116.0,
            width: 27.2.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover
              )
            ),
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
