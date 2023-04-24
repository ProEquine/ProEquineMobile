import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ProfileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.dividerColors,
      thickness: 2,
      height: 20,
      indent: 20.0,
      endIndent: 20.0,
    );
  }
}
