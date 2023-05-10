import 'package:flutter/material.dart';
import 'package:proequine/core/widgets/marketing_checkbox.dart';
import 'package:proequine/features/profile/presentation/screens/privacy_screen.dart';
import 'package:proequine/features/profile/presentation/screens/termsandcondition.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/headerText.dart';
import '../widgets/profile_list_tile_widget.dart';

class LegelScreen extends StatelessWidget {
  const LegelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            HeaderText("Legel", "",true),
            const SizedBox(
              height: 5,
            ),
            ProfileListTileWidget(
              title: "Terms & Conditions",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermsCondition()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Privacy Policy",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyScreen()));
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
