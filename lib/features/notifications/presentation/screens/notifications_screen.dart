import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:proequine/features/profile/data/verify_email_route.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../profile/presentation/screens/user_profile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  @override
  void initState() {
    checkVerificationStatus().then((verified) {
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                      arguments: VerifyEmailRoute(
                          type: 'notifications',
                          email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
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
                  top: 60, bottom: 1, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Inbox",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "hemiHead",
                    ),
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      AppIcons.userSquare,
                      height: 32,
                      width: 32,
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
                        image: AppImages.upComingEvent,
                        title: 'SERC - DPEC - 2 H',
                        id: "LT9664",
                        time: "10 mins ago",
                        transport: 'Event transport',
                        date: '15 Sep • 04:30 pm',
                        bookingTypeText: 'Booking completed',
                        statusImage: AppIcons.confirmed,
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
    );
  }
}
