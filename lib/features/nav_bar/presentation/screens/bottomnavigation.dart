import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/horses/presentation/screens/main_horses_screen.dart';
import 'package:proequine/features/nav_bar/domain/inbox_badge.dart';
import 'package:proequine/features/nav_bar/domain/navbar_cubit.dart';
import 'package:proequine/features/nav_bar/domain/theme_cubit.dart';
import 'package:proequine/features/manage_account/presentation/screens/user_profile.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../booking/presentation/screens/booking_main.dart';
import '../../../home/presentation/screens/main_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int? selectedIndex;

  const BottomNavigation({super.key, this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const BookingMain(),
    const MainHorsesScreen(),
    const NotificationsScreen(),

    const UserProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  ThemeCubit themeCubit=ThemeCubit();

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () =>
            BlocProvider.of<NavbarCubit>(context).onWillPop(context),
        child: BlocConsumer<ChangeBoolCubit, ChangeBoolState>(
          listener: (context, state){
            context.watch<ThemeCubit>().getSavedThemeMode();
          },
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                _widgetOptions.elementAt(_selectedIndex),
                BlurBottomView(
                    backgroundColor:
                    AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                        ? AppColors.backgroundColor
                        : AppColors.navigatorBar,
                    filterX: 21,
                    filterY: 21,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: AppColors.yellow,
                    unselectedItemColor: AppColors.grey,
                    opacity: 0.85,
                    bottomNavigationBarItems: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                        AppIcons.selectedHome,

                          color: _selectedIndex == 0
                              ? AppColors.yellow
                              : const Color(0XFF8B9299),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 1
                              ? AppIcons.selectedBookingIcon
                              : AppIcons.unSelectedBookingIcon,
                        ),
                        label: 'Services',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 2
                              ? AppIcons.selectedHorses
                              : AppIcons.unSelectedHorses,
                        ),
                        label: 'Horses',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.gold,
                        icon: Stack(
                          children: [
                            SvgPicture.asset(
                              _selectedIndex == 3
                                  ? AppIcons.selectedInbox
                                  : AppIcons.unSelectedInbox,
                            ),
                            Visibility(
                              visible: state.thereAreNotification,
                              child: Stack(
                                children: [
                                  Transform.translate(
                                    offset: const Offset(12, -3),
                                    child: const Icon(
                                      Icons.brightness_1,
                                      size: 10.0,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        label: 'Inbox',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 4
                              ? AppIcons.selectedProfile
                              : AppIcons.unSelectedProfile,
                        ),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    onIndexChange: (val) {
                      if (_selectedIndex == 3) {
                        BlocProvider.of<ChangeBoolCubit>(context)
                            .changeStatusToFalse();
                      }

                      _onItemTapped(val);
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
