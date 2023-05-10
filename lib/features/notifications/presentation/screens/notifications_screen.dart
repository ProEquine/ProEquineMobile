import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/titlebar.dart';
import '../../../profile/presentation/screens/user_profile.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
            child: Container(
              // color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Inbox",
                      style:  TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "hemiHead",
                      ),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(AppIcons.userSquare,height: 40,width: 40,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(),
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
      ),
      body: SingleChildScrollView(
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
                      transport: 'Event transport',
                      date: '15 Sep • 04:30 pm',
                      bookingTypeText: 'Booking completed',
                      statusImage: AppIcons.confirmed,
                      review: true,
                    ),
                  );
                }),
            const SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }
}
