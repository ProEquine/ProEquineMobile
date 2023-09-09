import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/home/presentation/screens/join_show_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../booking/presentation/widgets/booking_item_widget.dart';
import '../widgets/show_widget_item.dart';

class ShowsScreen extends StatefulWidget {
  String type;

  ShowsScreen({super.key, required this.type});

  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  List<String> images = [
    AppImages.ba,
    AppImages.eec,
    AppImages.serc,
    AppImages.eec
  ];
  List<String> status = [
    'Available',
    'Fully Booked',
    'Available',
    'Fully Booked'
  ];
  List<String> title = [
    'Emirates Longines League',
    'SERC 8th Training Show',
    'Emirates Longines League',
    'SERC 8th Training Show'
  ];
  List<String> from = ['30 Sep', '01 Oct', '14 Oct', '15 Oct'];
  List<String> to = ['30 Sep', '01 Oct', '14 Oct', '15 Oct'];
  List<String> type = ['Training', 'National', 'CSI1*, CSIYH1*', 'National'];

  final random = Random();

  @override
  Widget build(BuildContext context) {
// Generate a random index to select a random item
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Show Transport",
          isThereBackButton: true,
        ),
      ),

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    int randomIndex = random.nextInt(status.length);
                    String randomStatus = status[randomIndex];
                    String randomImage = images[randomIndex];
                    String randomTitle = title[randomIndex];
                    String randomfrom = from[randomIndex];
                    String randomTo = to[randomIndex];
                    String randomtype = type[randomIndex];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: kPadding),
                      child: ShowWidgetItem(
                        status: randomStatus,
                        title: randomTitle,
                        type: randomtype,
                        image: randomImage,
                        from: randomfrom,
                        to: randomTo,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  const JoinShowScreen(type: "Show Transport",)));
                        },
                      ),
                    );

                    // return Container(
                    //    color: Colors.black,
                    //    height: 40,
                    //    width: 90,
                    //  );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),

      // body: Column(
      //   children: const [
      //     SizedBox(height: 40,),
      //     NoBooking(),
      //   ],
      // ),
    );
  }
}
