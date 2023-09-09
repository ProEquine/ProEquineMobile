import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';


class ProfileListTileLoadingWidget extends StatefulWidget {

  ProfileListTileLoadingWidget(
      {super.key,
        });

  @override
  ProfileListTileLoadingWidgetState createState() => ProfileListTileLoadingWidgetState();
}

class ProfileListTileLoadingWidgetState extends State<ProfileListTileLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: () {
      },
      title: const FadeShimmer(
        baseColor: AppColors.shimmerColors,
        highlightColor: AppColors.borderColor,
        height: 10,
        width: 100,
        radius: 20,
      ),

      trailing:FadeShimmer.round(
        size: 12,
        baseColor: AppColors.shimmerColors,
        highlightColor: AppColors.borderColor,

      ),
    );
  }
}
