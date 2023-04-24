import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/profile/presentation/screens/user_profile.dart';
import 'package:sizer/sizer.dart';

import '../constants/images/app_images.dart';

class TitleBar extends StatelessWidget {
  final String title;
   bool isThereProfileButton=false;

  TitleBar(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "hemiHead",
          ),
        ),
        GestureDetector(
          child: SvgPicture.asset(AppIcons.userSquare),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile()));
          },
        ),
      ],
    );
  }
}
