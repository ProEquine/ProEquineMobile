import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:proequine/core/StartUp/StartUp.dart';
import 'package:proequine/core/widgets/submit_verify_email.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/associations/domain/associations_cubit.dart';
import 'package:proequine/features/bank_transfer/domain/bank_transfer_cubit.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:proequine/features/equine_info/presentation/screens/chose_discilpine_update_screen.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
import 'package:proequine/features/home/data/local_trip.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/presentation/screens/create_export_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_import_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_media_request_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/home/presentation/screens/join_show_screen.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:proequine/features/nav_bar/domain/inbox_badge.dart';
import 'package:proequine/features/nav_bar/domain/theme_cubit.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/manage_account/presentation/screens/add_second_number_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/manage_account_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/user_profile.dart';
import 'package:proequine/features/manage_account/presentation/screens/verify_email_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/verify_update_email_screen.dart';

import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';
import 'package:proequine/features/stables/domain/stable_cubit.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/stables/presentation/screens/choose_stable_screen.dart';
import 'package:proequine/features/wallet/domain/wallet_cubit.dart';
import 'package:proequine/theme_cubit_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/constants/routes/routes.dart';
import 'core/constants/thems/app_styles.dart';
import 'core/http/path_provider.dart';
import 'core/utils/Printer.dart';
import 'core/utils/secure_storage/secure_storage_helper.dart';
import 'core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'features/equine_info/presentation/screens/chose_stable_update_screen.dart';
import 'features/home/domain/repo/local_storage_repository.dart';
import 'features/manage_account/presentation/screens/update_phone_screen.dart';
import 'features/manage_account/presentation/screens/verify_updated_phone_screen.dart';
import 'features/nav_bar/domain/navbar_cubit.dart';
import 'features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'features/support/domain/support_cubit.dart';
import 'features/user/presentation/screens/login_screen.dart';
import 'features/user/presentation/screens/register_screen.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  await AppPathProvider.initPath();
  Stripe.publishableKey =
      'pk_test_51JSKeuJawRWtFfJ7Pl7OzShHujsSvaaB0KjNVa5eS4jR0F0NTmJHuXfW8lyyqKOb0OYpI3GWFsV2xGUmfgJjL6hh00C89XiTTu';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Stripe.instance.applySettings();
  await di.init();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(HorseAdapter());
  await Hive.openBox("horse");
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

LocalHorseCubit localHorseCubit =
    LocalHorseCubit(localStorageRepository: LocalStorageRepository());

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
      BlocProvider<SupportCubit>(
        create: (context) => SupportCubit(),
      ),
      BlocProvider<ManageAccountCubit>(
        create: (context) => ManageAccountCubit(),
      ),
      BlocProvider<LocalHorseCubit>(
        create: (context) => localHorseCubit,
      ),
      BlocProvider<EquineInfoCubit>(
        create: (context) => EquineInfoCubit(),
      ),
      BlocProvider<StableCubit>(
        create: (context) => StableCubit(),
      ),
      BlocProvider<HorseCubit>(
        create: (context) => HorseCubit(),
      ),
      BlocProvider<AssociationsCubit>(
        create: (context) => AssociationsCubit(),
      ),
      BlocProvider<WalletCubit>(
        create: (context) => WalletCubit(),
      ),
      BlocProvider<BankTransferCubit>(
        create: (context) => BankTransferCubit(),
      ),
      BlocProvider<ChangeBoolCubit>(
        create: (context) =>
            ChangeBoolCubit(ChangeBoolState(thereAreNotification: false)),
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
  ThemeCubit cubit = ThemeCubit();
  String? userId;

  Future<String> getUserId() async {
    userId = await SecureStorage().getUserId();
    return userId!;
  }

  deleteSecureStorage() async {
    final prefs = await SharedPreferences.getInstance();
    Print("first runnn");

    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = const FlutterSecureStorage();

      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }
  }

  @override
  void initState() {
    super.initState();
    // deleteSecureStorage();
    getUserId();
    BlocProvider.of<NotificationsCubit>(context).configOneSignal();
    Print("shared pref ${AppSharedPreferences.getTheme}");
    GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeCubitProvider(child:
        BlocBuilder<ThemeCubit, ThemeCubitMode>(builder: (context, themeMode) {
      Print("theme mode $themeMode");
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: MyApp.navigatorKey,
        theme: themeMode == ThemeCubitMode.dark
            ? AppStyles().darkTheme
            : AppStyles().lightTheme,
        // navigatorObservers: [MyNavigatorObserver()],
        title: 'Pro Equine',
        home: const SplashScreen(),
        routes: {
          loginRoute: (context) => const LoginScreen(),
          registerRoute: (context) => const RegisterScreen(),
          homeRoute: (context) => const BottomNavigation(),
          bookingRoute: (context) => const BottomNavigation(
                selectedIndex: 1,
              ),
          horses: (context) => const BottomNavigation(
                selectedIndex: 2,
              ),
          inboxRoute: (context) => const BottomNavigation(
                selectedIndex: 3,
              ),
          createTrip: ((context) => const CreateTripScreen()),
          createMedia: ((context) => const CreateMediaRequestScreen()),
          createEvent: ((context) => const JoinShowScreen()),
          import: ((context) => CreateImportScreen()),
          export: ((context) => CreateExportScreen()),
          // manageAccount: (context) =>  ManageAccountScreen(userId: int.parse(userId!),),
          userProfile: (context) => const UserProfile(),
          updatePhone: (context) => UpdatePhoneScreen(),
          // choseDiscipline: (context) => ChooseDisciplineScreen(
          //       userId: int.parse(userId!),
          //     ),
          choseStable: (context) => const ChoseStableScreen(),
          // choseUpdateStable: (context) =>
          //     ChooseUpdateStableScreen(userId: int.parse(userId!)),
          // addNewRole: (context) => const AddNewRoleScreen(),
          // allRoles: (context) => const AllRolesScreen(),
          addSecondaryPhone: (context) => AddSecondaryPhoneScreen(),
          verifyUpdatePhone: (context) => const VerifyUpdatedPhoneScreen(),
          verifyUpdateEmail: (context) => const VerifyUpdateEmailScreen(),
          submitVerifyEmail: (context) => SubmitVerifyEmail(),
          successScreen: (context) => SuccessStateScreen(),
          verifyEmail: (context) => const VerifyEmailScreen(),
        },
      );
    }));
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
