import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';

class CreateTripHeader extends StatelessWidget {
  final String? image;
  bool isFromTracking;

  CreateTripHeader({super.key, this.image, this.isFromTracking=false});

  @override
  Widget build(BuildContext context) {
    return isFromTracking
        ? Container(
      height: 180.0,
      width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.backgroundColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
                image:  AssetImage(
                  image!,
                ),
              ),
            ),
          )
        : Center(
            child: Container(
              height: 180.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: AssetImage(image!), fit: BoxFit.cover),
              ),
            ),
          );
  }
}
