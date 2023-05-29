import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/profile/presentation/widgets/history_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/header_text.dart';

class HistoryScreen extends StatefulWidget {
  final String? statusImg;
  final String? transport;
  final String? title;
  final String? refNumber;
  final String? horsesCount;

  const HistoryScreen({
    super.key,
    this.title,
    this.refNumber,
    this.statusImg,
    this.transport,
    this.horsesCount,
  });

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
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: HistoryWidget(
                      statusImg: AppIcons.confirmed,
                      title: 'complete',
                      refNumber: 'LT9664',
                      transport: 'Event transport • other day return ',
                      horsesCount: '4 Horses',
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
