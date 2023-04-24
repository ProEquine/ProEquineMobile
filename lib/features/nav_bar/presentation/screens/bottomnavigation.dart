import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/nav_bar/domain/navbar_cubit.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../booking/presentation/screens/booking_main.dart';
import '../../../events/presentation/screens/event_list_main.dart';
import '../../../home/presentation/screens/main_screen.dart';
import '../../../profile/presentation/screens/user_profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget> [
    MainScreen(),
    // ServicesDetails(),
    BookingMain(),
    EventListMain(),
    UserProfile(),
    // PostMain()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      body: WillPopScope(
        onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20.0,
                sigmaY: 20.0,
              ),
              child: Container(
                color: const Color.fromRGBO(38, 38, 38, 1).withOpacity(0.1),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  items:  <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(AppIcons.home,color: _selectedIndex==0?AppColors.gold:AppColors.white,),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(AppIcons.booking,color: _selectedIndex==1?AppColors.gold:AppColors.white,),
                      label: 'Booking',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(AppIcons.event,color: _selectedIndex==2?AppColors.gold:AppColors.white,),
                      label: 'Events',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: SvgPicture.asset(AppIcons.inbox,color: _selectedIndex==3?AppColors.gold:AppColors.white,),
                      label: 'Inbox',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: const Color.fromRGBO(196, 134, 54, 1),
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
