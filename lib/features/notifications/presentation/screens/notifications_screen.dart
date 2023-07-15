import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:proequine/features/profile/data/verify_email_route.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../profile/presentation/screens/user_profile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  NotificationsScreenState createState() => NotificationsScreenState();
}

class NotificationsScreenState extends State<NotificationsScreen> {
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
    //                       type: 'notifications',
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
                backgroundColor:
                    AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
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
                        child: Text(
                          "Inbox",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "hemiHead",
                            color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppColors.white
                                : AppColors.backgroundColor,
                          ),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 10),
                          child: NotificationWidget(
                            title: 'SERC - DPEC - 2 H',
                            id: "LT9664",
                            time: "10 mins ago",
                            transport: 'Event transport',
                            date: '15 Sep • 04:30 pm',
                            bookingTypeText: 'Booking completed',
                            review: true,
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
