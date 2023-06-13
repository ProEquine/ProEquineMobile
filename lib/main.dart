import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/app_settings.dart';
import 'package:proequine/core/StartUp/StartUp.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/submit_verify_email.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
import 'package:proequine/features/home/presentation/screens/create_event_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:proequine/features/profile/presentation/screens/account_information_screen.dart';
import 'package:proequine/features/profile/presentation/screens/update_phone_screen.dart';
import 'package:proequine/features/profile/presentation/screens/user_profile.dart';
import 'package:proequine/features/profile/presentation/screens/verify_email_screen.dart';
import 'package:proequine/features/profile/presentation/screens/verify_update_email_screen.dart';
import 'package:proequine/features/profile/presentation/screens/verify_updated_phone_screen.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/constants/routes/routes.dart';
import 'core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'features/nav_bar/domain/navbar_cubit.dart';
import 'features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'features/user/presentation/screens/login_screen.dart';
import 'features/user/presentation/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  // await Firebase.initializeApp();
  StartUp.setup();
  AppSettings.setup();
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
      BlocProvider<SplashCubit>(
        create: (context) => SplashCubit(),
      ),
      BlocProvider<NotificationsCubit>(
        create: (context) => NotificationsCubit(),
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
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationsCubit>(context).configOneSignal();
  }

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppStyles().mainTheme,
      navigatorObservers: [MyNavigatorObserver()],
      title: 'Pro Equine',
      home: const SplashScreen(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        homeRoute: (context) => const BottomNavigation(),
        bookingRoute: (context) => const BottomNavigation(
              selectedIndex: 1,
            ),
        inboxRoute: (context) => const BottomNavigation(
              selectedIndex: 2,
            ),
        createEvent: ((context) => const CreateEventScreen()),
        createTrip: ((context) =>  CreateTripScreen()),
        accountInfo: (context) => AccountInfoScreen(),
        userProfile: (context) => const UserProfile(),
        updatePhone: (context) => UpdatePhoneScreen(),
        verifyUpdatePhone: (context) => const VerifyUpdatedPhoneScreen(),
        verifyUpdateEmail: (context) => const VerifyUpdateEmailScreen(),
        submitVerifyEmail: (context) => SubmitVerifyEmail(),
        successScreen: (context) => SuccessStateScreen(),
        verifyEmail: (context) => const VerifyEmailScreen(),
      },
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // When the back button is pressed, prevent closing the page
    if (route.settings.name == '/') {
      SystemNavigator.pop();
    }
  }
}
