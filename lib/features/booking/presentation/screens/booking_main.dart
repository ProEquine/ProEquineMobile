import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../widgets/bookings.dart';

class BookingMain extends StatefulWidget {
  const BookingMain({super.key});

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  // Future<bool> checkVerificationStatus() async {
  //   if (AppSharedPreferences.getEmailVerified!) {
  //     return true;
  //   } else {
  //     await Future.delayed(
  //         const Duration(milliseconds: 50)); // Simulating an asynchronous call
  //     return false;
  //   }
  // }

  @override
  void initState() {
    // checkVerificationStatus().then((verified) {
    //   if (!verified) {
    //     // If the account is not verified, show a dialog after a delay.
    //     Future.delayed(const Duration(milliseconds: 50), () {
    //       showUnverifiedAccountDialog(
    //         context: context,
    //         isThereNavigationBar: true,
    //         onPressVerify: () {
    //           Navigator.pushNamed(context, verifyEmail,
    //                   arguments: VerifyEmailRoute(
    //                       type: 'Booking',
    //                       email: AppSharedPreferences.userEmailAddress))
    //               .then((value) {});
    //         },
    //       );
    //     });
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverLayoutBuilder(builder: (context, constraints) {
              final scrolled = constraints.scrollOffset > 10;
              return SliverAppBar(
                elevation: 5,
                automaticallyImplyLeading: false,
                backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? AppColors.backgroundColor
                    : AppColors.backgroundColorLight,
                expandedHeight: 60,
                flexibleSpace: ClipRect(
                  child: FlexibleSpaceBar(
                    expandedTitleScale: 1.4,
                    // centerTitle:  scrolled?true:false ,
                    title: Align(
                      alignment:
                          scrolled ? Alignment.topCenter : Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: scrolled ? 10 : 0,
                            left: scrolled ? 0 : kPadding),
                        child:  Text(
                          "Bookings",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "hemiHead",
                              color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                                  ? AppColors.white
                                  : AppColors.backgroundColor,),
                        ),
                      ),
                    ),
                  ),
                ),
                snap: true,
                floating: true,
                pinned: true,
              );
            }),
          ],
          body: const Padding(
            padding:
                EdgeInsets.only(left: kPadding, right: kPadding, bottom: 20),
            child: Booking(),
          ),
        ),
        //TODO: CHANGE HERE IF THE BOOKINGS IS EMPTY
        //     body: const SafeArea(
        //     child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
        // child: NoBooking()
      ),
    );
  }
}
