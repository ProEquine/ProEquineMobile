import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/features/splash/data/refresh_request_model.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/printer.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../user/presentation/screens/login_screen.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../user/presentation/screens/videoScreen.dart';

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
    if (!await launch(_appUrl)) throw 'Could not launch $_appUrl';
  }

  SplashCubit splashCubit = SplashCubit();

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
    if (AppSharedPreferences.getFirstTime!) {
      if (AppSharedPreferences.accessToken.isNotEmpty) {
        Print("token${AppSharedPreferences.accessToken}");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()));
      } else {
        /// edited from login to testPage
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const VideoPlayerScreen()));
    }
  }

  Future<void> startTimer() async {
    Timer(const Duration(seconds: 3), () async {
      await navigateUser();
    });
  }

  @override
  void initState() {
    startTimer();
    // getVersion();
    splashCubit.refreshToken(RefreshRequestModel(
        refreshToken: AppSharedPreferences.refreshToken,
        userId: AppSharedPreferences.userId));
    super.initState();
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
            offset: const Offset(0.0,-30.0),
            child: Center(
              child: Image.asset(AppImages.logo,scale: 3,),
            ),
          ),
        ],
      ),
    );
  }
}
