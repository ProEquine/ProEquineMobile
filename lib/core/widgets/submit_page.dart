import 'package:flutter/material.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/booking/presentation/screens/booking_main.dart';

import '../../features/nav_bar/presentation/screens/bottomnavigation.dart';

class SubmitedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 6,
          ),
          Center(
            child: SizedBox(
              height: 176,
              width: 176,
              child: Image.asset(AppImages.submit),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              "Your request has been submitted successfully",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'notosan'),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RebiButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(
                                selectedIndex: 1,
                              )));
                },
                child: const Text("View my booking")),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
