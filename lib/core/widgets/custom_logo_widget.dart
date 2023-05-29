import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.h,
      child: Image.asset(AppImages.logo,scale: 1,),
    );
  }
}
