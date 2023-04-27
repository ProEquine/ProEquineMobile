import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/StartUp/StartUp.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/empty_bookings.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
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
  await Firebase.initializeApp();
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

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((fcmToken) {
      Print("FCm Token$fcmToken");
      AppSharedPreferences.deviceId=fcmToken!;
      Print(fcmToken);
    });

  }
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppStyles().mainTheme,
      title: 'Pro Equine',
      home: const EmptyBookingsWidget(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        '/homeRoute': (context) => const BottomNavigation(),
        transportRoute: (context) => const BookTransport(),
        eventRoute: ((context) => const BookEvent()),
        '/confirm': ((context) => const ConfirmScreen()),
      },
    );
  }
}
