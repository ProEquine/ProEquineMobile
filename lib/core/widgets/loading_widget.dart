import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class LoadingCircularWidget extends StatelessWidget {
  const LoadingCircularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        backgroundColor:AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? AppColors.white
            : AppColors.yellow,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
      ),
    );
  }
}
