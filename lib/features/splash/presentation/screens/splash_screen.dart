import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/splash/data/refresh_request_model.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../notifications/data/saved_notification_data.dart';
import '../../../user/presentation/screens/interests_screen.dart';
import '../../../user/presentation/screens/login_screen.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin {
  late final AnimationController _controller;
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

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = 'version: ${packageInfo.version}';
    buildVersion = "${packageInfo.version}.${packageInfo.buildNumber}";
    packageName = packageInfo.packageName;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');

    Print('version: ${packageInfo.version}');
    Print('build Version: ${packageInfo.buildNumber}');
    Print('build Version with build number: $buildVersion');
    Print('name: ${packageInfo.packageName}');
  }

  Future<void> navigateUser() async {
    Print(
        "saved data from notification ${SavedNotificationData.notificationData}");
    if (SavedNotificationData.notificationData != null) {
      Print("render from splash screen");
    } else {
      if (await SecureStorage().hasToken()) {
        if (AppSharedPreferences.getIsITypeSelected!) {
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigation()));
          }
        } else {
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserInfoScreen()));
          }
        }
      } else {
        /// edited from login to testPage
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }
    }
  }

  Future<void> startTimer() async {
    Timer(const Duration(seconds: 2), () async {
      await navigateUser();
    });
  }

  String? refreshToken = '';
  String? userId = '';

  sendRefreshToken() async {
    refreshToken = await SecureStorage().getRefreshToken();
    userId = await SecureStorage().getUserId();
    Print("User Id $userId");
    Print("Refresh Token $refreshToken");
    splashCubit.refreshToken(
        RefreshRequestModel(refreshToken: refreshToken, userId: userId));
  }

  deleteSecureStorage() async {
    if (!AppSharedPreferences.getFirstTime!) {
      await SecureStorage().deleteToken();
      await SecureStorage().deleteRefreshToken();
      await SecureStorage().deleteDeviceId();
      await SecureStorage().deleteUserId();
      Print("All Deleted");
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    getVersion();
    if (AppSharedPreferences.getEnvType != '') {
      // startTimer();
    } else {
      getVersion();
      // Timer(const Duration(seconds: 3), () async {
      //   await startTimer();
      // });
    }

    // deleteSecureStorage();
    sendRefreshToken();
    // notificationsCubit.configOneSignal();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    sendRefreshToken();
    // splashCubit.close();
    // notificationsCubit.close();
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
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w,),
              child: Lottie.asset(


                'assets/animation/splash.json',

                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.

                      _controller
                  ..duration = composition.duration
                  ..forward().whenComplete(() =>
                  startTimer());



                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
