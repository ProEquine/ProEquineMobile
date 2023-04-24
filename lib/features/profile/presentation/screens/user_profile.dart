import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/profile/presentation/screens/account_information_screen.dart';
import 'package:proequine/features/profile/presentation/screens/history_screen.dart';
import 'package:proequine/features/profile/presentation/screens/horses_screen.dart';
import 'package:proequine/features/profile/presentation/screens/privacy_screen.dart';

import 'package:proequine/features/profile/presentation/widgets/profile_divider.dart';
import 'package:proequine/features/profile/presentation/widgets/profile_list_tile_widget.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Profile",
          isThereBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileListTileWidget(
              title: "Notifications",
              subTitle: "View your latest trips updates",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()));
              },
              notificationList: true,
              isThereNewNotification: true,
            ),
            ProfileDivider(),
            ProfileListTileWidget(
              title: "Horses",
              subTitle: "Manage / add your horses",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HorsesScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileDivider(),
            ProfileListTileWidget(
              title: "Account",
              subTitle: "updating your account information",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountInfoScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileDivider(),
            ProfileListTileWidget(
              title: "History",
              subTitle: "View your requests history",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileDivider(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: RebiButton(
                onPressed: () {
                  AppSharedPreferences.clearForLogOut();
                  RebiMessage.success(msg: "Logout Successfully");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: AppColors.white),
                ),
                radius: 76,
                backgroundColor: AppColors.formsBackground,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Privacy policy & Legal",
                  style: const TextStyle(
                      color: AppColors.grey,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyScreen()));
                    }),
            ]))
          ],
        ),
      ),
    );
  }
}
