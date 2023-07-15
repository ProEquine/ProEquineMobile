import 'package:flutter/material.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 10,
      thickness: 3,
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark' ? Color(
          0XFF36393D) : Color(0xFFD1D5DB),
      endIndent: 30.0,
      indent: 30.0,
    );

  }
}
