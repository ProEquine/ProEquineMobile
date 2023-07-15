import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({
    Key? key,
    required this.title,
    this.isThereBackButton = true,
    this.isThereChangeWithNavigate = false,
    this.onPressBack,
    this.onPressUp,
  }) : super(key: key);

  final String title;
  final bool isThereBackButton;
  bool isThereChangeWithNavigate = false;

  final Function? onPressBack;
  final Function? onPressUp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isThereBackButton
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Transform(
                    // alignment: Alignment.center,
                    transform: Directionality.of(context) == TextDirection.rtl
                        ? Matrix4.rotationY(math.pi)
                        : Matrix4.rotationY(0),
                    child: GestureDetector(
                        onTap: () {
                          isThereChangeWithNavigate
                              ? onPressBack!()
                              : Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new,
                            color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppColors.white
                                : Colors.black)),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.white
                              : Colors.black,
                      fontSize: 28.0,
                      fontFamily: 'hemiHead',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                              ? AppColors.white
                              : Colors.black,
                      fontSize: 28.0,
                      fontFamily: 'hemiHead',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Transform(
                  //   // alignment: Alignment.center,
                  //   transform: Directionality.of(context) == TextDirection.rtl
                  //       ? Matrix4.rotationY(math.pi)
                  //       : Matrix4.rotationY(0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       isThereChangeWithNavigate
                  //           ? onPressUp!()
                  //           : Navigator.pop(context);
                  //     },
                  //     child: Container(
                  //         padding: const EdgeInsets.all(12),
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: AppColors.formsBackground,
                  //         ),
                  //         child: Transform.scale(
                  //           scale: 2.5,
                  //           child: const Icon(
                  //             Icons.keyboard_arrow_down,
                  //             size: 15,
                  //             color: AppColors.white,
                  //           ),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}
