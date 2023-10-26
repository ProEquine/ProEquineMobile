import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../constants/images/app_images.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({
    Key? key,
    this.errorMessage,
    required this.onRetry,
    this.buttonText,
  }) : super(key: key);

   String? errorMessage;
  final Function onRetry;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 50.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //TODO: replace with error image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SvgPicture.asset(
              AppIcons.errorIcon,
              height: 20.h,
            ),
          ),

          Text(
            errorMessage??'Oops! Something went wrong. Please try again.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          RebiButton(
            onPressed: () {
              onRetry();
            },
            child: Text(
              buttonText ?? 'Try again'.tra,
            ),
          ),
        ],
      ),
    );
  }
}
