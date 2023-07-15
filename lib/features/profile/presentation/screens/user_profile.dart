import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:proequine/features/profile/presentation/screens/history_screen.dart';

import 'package:proequine/features/profile/presentation/screens/support.dart';
import 'package:proequine/features/profile/presentation/widgets/profile_list_tile_widget.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/delete_popup.dart';
import '../../../../theme_cubit_provider.dart';
import '../../../nav_bar/domain/theme_cubit.dart';
import 'legal.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ProfileCubit cubit = ProfileCubit();
  String? email;

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Profile",
          isThereBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              ProfileListTileWidget(
                title: "Account",
                onTap: () async {
                  Navigator.pushNamed(context, accountInfo, arguments: false)
                      .then((value) => email = value.toString());
                  Print(email);
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              // ProfileDivider(),
              ProfileListTileWidget(
                title: "History",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen()));
                },
                notificationList: false,
                isThereNewNotification: false,
              ),
              // ProfileDivider(),
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
                  text: TextSpan(children: [
                TextSpan(
                  text: email ?? AppSharedPreferences.userEmailAddress,
                  style: const TextStyle(
                    color: AppColors.grey,
                  ),
                ),
              ])),

              Text(
                context.watch<ThemeCubit>().state.toString(),
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gold),
              ),
              const SizedBox(height: 16),
              Switch(

                onChanged: (value) {
                  themeCubit.toggleTheme();
                },
                value: context.watch<ThemeCubit>().state.toString() ==
                        'ThemeCubitMode.dark'
                    ? true
                    : false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
