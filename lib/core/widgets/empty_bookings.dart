import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';

class EmptyBookingsWidget extends StatelessWidget {
  const EmptyBookingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          Center(
            child: SizedBox(
              height: 40.0.h,
              width: 90.w,
              child: Image.asset(AppImages.emptyBookings),
            ),
          ),
          const SizedBox(height: 10,),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 5.0.w),
             child: const Text("Looks like you don’t have any bookings ...",style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500,fontFamily: 'notosan',fontSize: 32),),
           )
        ],
      ),
    );
  }
}
