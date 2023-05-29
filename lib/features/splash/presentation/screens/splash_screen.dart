import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/splash/data/refresh_request_model.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../user/presentation/screens/interests_screen.dart';
import '../../../user/presentation/screens/login_screen.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String _appUrl = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.findyourteam.mobile'
      : 'https://apps.apple.com/us/app/fyt-find-your-team/id1644097919';
  String version = '';
  String buildVersion = '';
  String packageName = '';

  void updateApp() async {
    if (!await launchUrl(Uri.parse(_appUrl))) throw 'Could not launch $_appUrl';
  }

  SplashCubit splashCubit = SplashCubit();
  NotificationsCubit notificationsCubit = NotificationsCubit();

  // getVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   version = 'version: ${packageInfo.version}';
  //   buildVersion = "${packageInfo.version}.${packageInfo.buildNumber}";
  //   packageName = packageInfo.packageName;
  //
  //   Print('version: ${packageInfo.version}');
  //   Print('name: ${packageInfo.packageName}');
  // }

  Future<void> navigateUser() async {
    if (await SecureStorage().hasToken()) {
      if (AppSharedPreferences.getPhoneVerified!) {
        if (AppSharedPreferences.getIsITypeSelected!) {
          if (context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BottomNavigation()));
          }
        } else {
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InterestsScreen()));
          }
        }
      } else {
        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationScreen(
                      phone: AppSharedPreferences.userPhoneNumber)));
        }
      }
      Print("has token${await SecureStorage().hasToken()}");
      Print("verified phone${AppSharedPreferences.getPhoneVerified}");
    } else {
      /// edited from login to testPage
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    }
  }

  Future<void> startTimer() async {
    Timer(const Duration(seconds: 3), () async {
      await navigateUser();
    });
  }

  String? refreshToken = '';
  String? userId = '';

  sendRefreshToken() async {
    refreshToken = (await SecureStorage().getRefreshToken())!;
    userId = (await SecureStorage().getUserId())!;
    Print(userId);
    Print(refreshToken);
    splashCubit.refreshToken(
        RefreshRequestModel(refreshToken: refreshToken, userId: userId));
  }

  @override
  void initState() {
    startTimer();
    sendRefreshToken();
    notificationsCubit.configOneSignal();

    super.initState();
  }
  @override
  void dispose() {
    splashCubit.close();
    notificationsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          // buildDialogForUpdate(),
          // const BackgroundImage(),
          Transform.translate(
            offset: const Offset(0.0, -30.0),
            child: Center(
              child: Image.asset(
                AppImages.logo,
                scale: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
