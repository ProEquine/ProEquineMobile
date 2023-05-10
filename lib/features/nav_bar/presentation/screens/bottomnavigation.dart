import 'dart:ui';
import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/nav_bar/domain/navbar_cubit.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../booking/presentation/screens/booking_main.dart';
import '../../../events/presentation/screens/event_list_main.dart';
import '../../../home/presentation/screens/main_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';

class BottomNavigation extends StatefulWidget {
  int? selectedIndex;
  BottomNavigation({super.key,this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;

  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const BookingMain(),
    const EventListMain(),
    NotificationsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    _selectedIndex=widget.selectedIndex??0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(),
        child: Stack(
          children: <Widget>[
            _widgetOptions.elementAt(_selectedIndex),
            BlurBottomView(
                filterX: 21,
                filterY: 21,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: AppColors.gold,
                opacity: 0.8,
                bottomNavigationBarItems: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      AppIcons.home,
                      color: _selectedIndex == 0
                          ? AppColors.gold
                          : AppColors.white,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      AppIcons.booking,
                      color: _selectedIndex == 1
                          ? AppColors.gold
                          : AppColors.white,
                    ),
                    label: 'Booking',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: AppColors.gold,
                    icon: SvgPicture.asset(
                      AppIcons.event,
                      color: _selectedIndex == 2
                          ? AppColors.gold
                          : AppColors.white,
                    ),
                    label: 'Events',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      AppIcons.inbox,
                      color: _selectedIndex == 3
                          ? AppColors.gold
                          : AppColors.white,
                    ),
                    label: 'Inbox',
                  ),
                ],
                currentIndex: _selectedIndex,
                onIndexChange: (val) {
                  _onItemTapped(val);
                }),
          ],
        ),
      ),
    );
  }
}
