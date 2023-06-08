import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';

import '../constants/colors/app_colors.dart';
import '../constants/images/app_images.dart';

void showUnverifiedAccountDialog(
    {required BuildContext context,
    required bool isThereNavigationBar,
    required Function onPressVerify}) {
  if (!AppSharedPreferences.getEmailVerified!) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Dialog(
              backgroundColor: AppColors.formsBackground,
              insetPadding: const EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 19, left: 19, right: 19, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(AppIcons.email),
                    const SizedBox(height: 21),
                    const Text(
                      "Verify your email address To access all features",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 19),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()));
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(100, 33),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.5),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onPressVerify();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 33),
                            backgroundColor: AppColors.yellow,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.5),
                              ),
                            ),
                          ),
                          child: const Text('Verify'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
