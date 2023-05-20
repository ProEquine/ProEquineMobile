import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:proequine/features/profile/presentation/screens/account_information_screen.dart';
import 'package:proequine/features/profile/presentation/screens/history_screen.dart';
import 'package:proequine/features/profile/presentation/screens/legel.dart';
import 'package:proequine/features/profile/presentation/screens/support.dart';
import 'package:proequine/features/profile/presentation/widgets/profile_list_tile_widget.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/delete_popup.dart';
import '../../../../core/widgets/headerText.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ProfileCubit cubit = ProfileCubit();

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
            HeaderText("Profile", "", true),
            const SizedBox(
              height: 5,
            ),
            ProfileListTileWidget(
              title: "Account",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountInfoScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            // ProfileDivider(),
            ProfileListTileWidget(
              title: "History",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            // ProfileDivider(),
            ProfileListTileWidget(
              title: "Legel",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LegelScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Support",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Support()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Logout",
              onTap: () async {
                AppSharedPreferences.clearForLogOut();
                await SecureStorage().deleteUserId();
                await SecureStorage().deleteDeviceId();
                await SecureStorage().deleteRefreshToken();
                await SecureStorage().deleteToken();
                RebiMessage.success(msg: "Logout Successfully");
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()));
                }
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              isDeleteAccount: true,
              title: "Delete Account",
              onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => DeletePopup()),
              notificationList: false,
              isThereNewNotification: false,
            ),
            const SizedBox(
              height: 50,
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: "faizan.k@input.ae",
                style: TextStyle(
                  color: AppColors.grey,
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
