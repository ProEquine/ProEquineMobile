import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class EmptyHorsesWidget extends StatelessWidget {
  const EmptyHorsesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 200,),
          Center(
            child: SizedBox(
              height: 30.0.h,
              width: 70.w,
              child: SvgPicture.asset(AppIcons.horse),
            ),
          ),
          // Spacer(),
          const SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: const Text("Add Your horse and lets get started",style:  TextStyle(
                color: AppColors.blackLight,
                fontSize: 28.26,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.94,

            ),),
          ),
          // SizedBox(height: 100,)
        ],
      ),
    );
  }
}
