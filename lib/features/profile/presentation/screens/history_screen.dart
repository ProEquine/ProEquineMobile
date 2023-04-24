import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/profile/presentation/widgets/history_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';

class HistoryScreen extends StatefulWidget {
  String? imageUrl;
  String? transport;
  String? title;
  String? date;
  String? horsesCount;
  String? from;
  String? to;

  HistoryScreen(
      {super.key,
      this.title,
      this.date,
      this.imageUrl,
      this.transport,
      this.horsesCount,
      this.from,
      this.to});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "History",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
                child: HistoryWidget(
                  imageUrl: AppImages.upComingEvent,
                  title: 'SERC - DPEC - 2 H',
                  transport: 'Event transport • other day return ',
                  date: '15 Sep • 04:30 pm',
                  horsesCount: '2 Horses',
                  from: 'Al Habtoor Polo Club',
                  to: 'SERC',
                ),
              );
            }),
      ),
    );
  }
}
