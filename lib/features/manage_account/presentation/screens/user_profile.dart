import 'package:flutter/material.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/equine_info/presentation/screens/equine_info_screen.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';


import '../../../../core/constants/routes/routes.dart';

import '../../../support/presentation/screens/legal.dart';
import '../../../support/presentation/screens/social_media_screen.dart';
import '../../../support/presentation/screens/support.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ManageAccountCubit cubit = ManageAccountCubit();
  String? email;

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 95,
            ),
            const Text(
              'Hi, Abdalla',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Account Information",
                style: AppStyles.profileTitles,
                textAlign: TextAlign.start,
              ),
            ),
            ProfileListTileWidget(
              title: "Manage Account",
              onTap: () async {
                Navigator.pushNamed(context, editProfile, arguments: false)
                    .then((value) => email = value.toString());
                Print(email);
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Equine Info",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EquineInfoScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "More About ProEquine",
                style: AppStyles.profileTitles,
                textAlign: TextAlign.start,
              ),
            ),
            // ProfileDivider(),

            ProfileListTileWidget(
              title: "Support",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Support()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Legal",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LegalScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "We're on social media",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SocialMediaScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            const Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextButton(
                onPressed: () async {
                  AppSharedPreferences.clearForLogOut();
                  await SecureStorage().deleteUserId();
                  await SecureStorage().deleteDeviceId();
                  await SecureStorage().deleteRefreshToken();
                  await SecureStorage().deleteToken();
                  AppSharedPreferences.phoneVerified = false;
                  AppSharedPreferences.typeSelected = false;
                  AppSharedPreferences.emailVerified = false;
                  if (context.mounted) {
                    RebiMessage.success(
                        msg: "Logout Successfully", context: context);
                  }

                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()));
                  }
                },
                child: const Center(
                  child: Text("Logout",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontFamily: "notosan",
                        color: AppColors.blackLight,
                      )),
                ),
              ),
            ),
            Center(
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "v1.0",
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
              ])),
            ),

            const Spacer(
              flex: 2,
            ),

            // Text(
            //   context
            //       .watch<ThemeCubit>()
            //       .state
            //       .toString(),
            //   style: const TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: AppColors.gold),
            // ),
            // const SizedBox(height: 16),
            // Switch(
            //
            //   onChanged: (value) {
            //     themeCubit.toggleTheme();
            //   },
            //   value: context.watch<ThemeCubit>().state.toString() ==
            //           'ThemeCubitMode.dark'
            //       ? true
            //       : false,
            // ),
          ],
        ),
      ),
    );
  }
}
