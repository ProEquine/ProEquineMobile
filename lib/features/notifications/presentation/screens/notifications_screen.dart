import 'package:flutter/material.dart';
import 'package:proequine/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/custom_header.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Notifications",
          isThereBackButton: true,
        ),
      ),
      body:SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                 const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
                child: NotificationWidget(
                  image: AppImages.upComingEvent,
                  title: 'SERC - DPEC - 2 H',
                  transport: 'Event transport',
                  date: '15 Sep • 04:30 pm',
                  bookingTypeText: 'Booking Confirmed',
                  statusImage: AppIcons.confirmed,
                  review: true,
                ),
              );
            }),
      ),
    );
  }
}
