import 'package:flutter/material.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class CreateTripHeader extends StatelessWidget {
  final String?image;
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
      ],
    );
  }
}
