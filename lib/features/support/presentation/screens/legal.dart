import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';
import '../widgets/privacy_bottom_sheet.dart';
import '../../../../core/widgets/terms_bottom_sheet.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              ProfileListTileWidget(
                title: "Terms & Conditions",
                onTap: () {
                  showTermsBottomSheet(context: context);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              ProfileListTileWidget(
                title: "Privacy Policy",
                onTap: () {
                  showPrivacyBottomSheet(context:context
                  );
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
