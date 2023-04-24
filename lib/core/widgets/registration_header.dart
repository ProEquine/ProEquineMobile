import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        AppImages.shape,
        fit: BoxFit.cover,
      ),
    );
  }
}
