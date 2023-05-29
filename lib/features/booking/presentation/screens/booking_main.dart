import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../profile/data/verify_email_route.dart';
import '../../../profile/presentation/screens/user_profile.dart';
import '../widgets/bookings.dart';

class BookingMain extends StatefulWidget {
  const BookingMain({super.key});

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  Future<bool> checkVerificationStatus() async {
  if(AppSharedPreferences.getEmailVerified!){
    return true;
  }else{
    await Future.delayed(const Duration(milliseconds: 50)); // Simulating an asynchronous call
    return false;
  }
  }
  @override
  void initState() {
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(context: context, isThereNavigationBar: true,onPressVerify: () {
            Navigator.pushNamed(context, verifyEmail, arguments:VerifyEmailRoute(type: 'Booking',email: AppSharedPreferences.userEmailAddress))
                .then((value) {});
          },);
        });
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                      AppIcons.userSquare,
                      height: 32,width: 32,
                    ),
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
