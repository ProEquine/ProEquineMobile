import 'package:flutter/material.dart';
import 'package:proequine/features/profile/presentation/screens/privacy_screen.dart';
import 'package:proequine/features/profile/presentation/screens/termsandcondition.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../widgets/profile_list_tile_widget.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Legal",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            ProfileListTileWidget(
              title: "Terms & Conditions",
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const TermsCondition(),
                  transitionDuration: const Duration(milliseconds: 300),
                  // Set duration
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, 1.0); // Set begin offset
                    var end = Offset.zero; // Set end offset
                    var curve = Curves.easeOut; // Set curve

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
                );
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Privacy Policy",

                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const PrivacyScreen(),
                    transitionDuration: const Duration(milliseconds: 300),
                    // Set duration
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(0.0, 1.0); // Set begin offset
                      var end = Offset.zero; // Set end offset
                      var curve = Curves.easeOut; // Set curve

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                  );
                },

              notificationList: false,
              isThereNewNotification: false,
            ),
          ],
        ),
      ),
    );
  }
}
