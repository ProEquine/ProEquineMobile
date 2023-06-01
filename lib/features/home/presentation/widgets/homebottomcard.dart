import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:sizer/sizer.dart';

class HomeBottomCard extends StatelessWidget {
  const HomeBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage(AppImages.comingSoon),
          fit: BoxFit.cover,
        ),
      ),
      child: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
             child: Text(
                'coming soon!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700,fontFamily: 'notosan',color: Colors.white),
              ),

        ),

    );
  }
}
