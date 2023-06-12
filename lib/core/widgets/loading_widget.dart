import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class LoadingCircularWidget extends StatelessWidget {
  const LoadingCircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }
}
