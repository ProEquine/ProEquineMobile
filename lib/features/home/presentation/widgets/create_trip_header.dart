import 'package:flutter/material.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class CreateTripHeader extends StatelessWidget {
  String?image;

  CreateTripHeader({super.key,this.image});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 43.0.h,
          width: double.infinity,
          decoration:  BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image!)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.formsBackground,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/homeRoute');
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.white,
                ),
              )),
        ),
      ],
    );
  }
}
