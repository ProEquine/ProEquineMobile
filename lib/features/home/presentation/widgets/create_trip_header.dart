import 'package:flutter/material.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class CreateTripHeader extends StatelessWidget {
  final String?image;
   // bool isThereVerifyEmail;
   // Function? onTapBack;

   CreateTripHeader({super.key,this.image});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40.0.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(image!),fit: BoxFit.cover),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        //   child: Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppColors.formsBackground,
        //       ),
        //       child: InkWell(
        //         onTap: () {
        //           if (isThereVerifyEmail) {
        //             onTapBack!();
        //           } else {
        //             Navigator.pop(context);
        //           }
        //         },
        //         child: const Icon(
        //           Icons.arrow_back_ios_new,
        //           color: AppColors.white,
        //         ),
        //       )),
        // ),
      ],
    );
  }
}
