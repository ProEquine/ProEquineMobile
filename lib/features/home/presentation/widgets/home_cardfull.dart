import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';

class HomeCardFull extends StatelessWidget {
  const HomeCardFull({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage(AppImages.homeCardFull),
          fit: BoxFit.contain,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.center,
                end: FractionalOffset.bottomCenter,
                colors: [
              Colors.transparent,
              AppColors.backgroundColor
              // I don't know what Color this will be, so I can't use this
            ])),
        child: Transform.translate(
          offset: const Offset(0.0, 10),
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Transportation',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
