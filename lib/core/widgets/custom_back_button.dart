import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, this.size = 30}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.maybePop(context);
        },
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.formsBackground,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 26,
                color: AppColors.formsBackground,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoIcons.back
                  : Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
