import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../constants/images/app_images.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
    this.buttonText,
  }) : super(key: key);

  final String errorMessage;
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
          Image.asset(
            AppImages.error,
            height: 20.h,
          ),

          Text(
            errorMessage,
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
