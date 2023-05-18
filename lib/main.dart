import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:proequine/core/StartUp/StartUp.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/constants/routes/routes.dart';
import 'core/utils/Printer.dart';
import 'core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'core/widgets/confirm_screen.dart';
import 'features/booking/presentation/screens/book_transport.dart';
import 'features/events/presentation/screens/event_booking.dart';
import 'features/nav_bar/domain/navbar_cubit.dart';
import 'features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'features/user/presentation/screens/login_screen.dart';
import 'features/user/presentation/screens/register_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  // await Firebase.initializeApp();
  StartUp.setup();
  String? defaultLocale = Platform.localeName;
  if (defaultLocale.substring(0, 2) == 'en') {
    defaultLocale = 'en';
  } else if (defaultLocale.substring(0, 2) == 'ar') {
    defaultLocale = 'ar';
  } else {
    defaultLocale = 'en';
  }
  Locale? startLocale;
  startLocale = languages['en'];
  AppSharedPreferences.lang = 'en';
  runApp(
    EasyLocalization(
      startLocale: startLocale,
      supportedLocales: languages.values.toList(),
      path: "assets/languages",
      child: _blocProvider(),
    ),
  );
}

_blocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<NavbarCubit>(
        create: (context) => NavbarCubit(),
      ),
      BlocProvider<UserCubit>(
        create: (context) => UserCubit(),
      ),
      BlocProvider<EventCubit>(
        create: (context) => EventCubit(),
      ),
      BlocProvider<ProfileCubit>(
        create: (context) => ProfileCubit(),
      ),

    ],
    child: const ResponsiveSizer(),
  );
}

class ResponsiveSizer extends StatelessWidget {
  const ResponsiveSizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  MyApp();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void configOneSignal() async {
    await OneSignal.shared.setAppId('ef8bd521-54d4-4a21-b1f3-654755149b50');

    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    Print("Device ID ${osUserID.toString()}");
    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      //  print(changes.to.userId);
      String? userId = changes.to.userId ?? '';
      if (userId != '') {
        AppSharedPreferences.setDeviceId = userId.toString();
      }
    });
    AppSharedPreferences.setDeviceId = osUserID!.toString();

    Print("Device Id From Shared Pref ${AppSharedPreferences.getDeviceId}");

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    /// Calls when the notification opens the app.
    // OneSignal.shared.setNotificationOpenedHandler(handleBackgroundNotification);

    await OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      Print("Accepted permission: $accepted");
    });
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  }

  @override
  void initState() {
    super.initState();
configOneSignal();

  }
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppStyles().mainTheme,
      title: 'Pro Equine',
      home:  const SplashScreen(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        '/homeRoute': (context) => BottomNavigation(),
        transportRoute: (context) => const BookTransport(),
        eventRoute: ((context) => const BookEvent()),
        '/confirm': ((context) => const ConfirmScreen()),
      },
    );
  }
}
