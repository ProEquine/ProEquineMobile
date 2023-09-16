import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class EmptyServiceScreen extends StatelessWidget {
  final String serviceType;
  bool isComingSoon=false;

  EmptyServiceScreen({Key? key, required this.serviceType, this.isComingSoon=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: kPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 200,),
          Center(
            child: serviceType == 'Media'
                ? SvgPicture.asset(AppIcons.emptyMedia)
                : serviceType == 'Shipping'
                    ? SvgPicture.asset(AppIcons.emptyShipping)
                    : SvgPicture.asset(AppIcons.emptyTransport),
          ),
          const SizedBox(
            height: 40,
          ),
          isComingSoon?const Center(
            child: Text(
              'Coming Soon ...',
              style: TextStyle(
                color: AppColors.blackLight,
                fontSize: 28.26,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.94,
              ),
            ),
          ):Center(
            child: Text(
              'Looks like you don’t have any $serviceType ...',
              style: const TextStyle(
                color: AppColors.blackLight,
                fontSize: 28.26,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.94,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isComingSoon?const SizedBox():Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(
                Icons.arrow_downward_outlined,
                color: AppColors.formsHintFontLight,
              ),
              SizedBox(width: 5,),
              Text('Explore our Services',style: TextStyle(
                color: AppColors.formsHintFontLight,
                fontSize: 11.30,
                fontFamily: 'notosan',
                fontWeight: FontWeight.w600,
              ),)
            ],
          )
        ],
      ),
    );
  }
}
