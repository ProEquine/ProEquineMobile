import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_email_dialog.dart';
import '../../../profile/presentation/screens/user_profile.dart';
import '../widgets/bookings.dart';


class BookingMain extends StatefulWidget {
  const BookingMain({super.key});

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  @override
  Widget build(BuildContext context) {
    if (!AppSharedPreferences.getEmailVerified!) {
      return VErifyEmailDialog(
        isThereNavigationBar: true,
        onPressVerify: () {
          setState(() {
            Navigator.pushNamed(context, '/sendEmail',arguments: "Booking").then((value) {
              setState(() {
              });
            });
          });
        },
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(23.0.h),
          child: ClipRect(
            child: BackdropFilter(
              // blendMode: BlendMode.color,
              filter: ImageFilter.blur(
                sigmaX: 30.0,
                sigmaY: 30.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bookings",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "hemiHead",
                      ),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(
                        AppIcons.userSquare, height: 40, width: 40,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfile(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Booking(),
            )),
      );
    }
  }
}
