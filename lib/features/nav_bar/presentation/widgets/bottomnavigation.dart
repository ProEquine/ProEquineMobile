
/// Black Navigation Bar for confirm what's already using

// import 'package:flutter/material.dart';
// import 'package:proequine/screens/evnets/event_booking.dart';
// import 'package:proequine/screens/service/services_details.dart';
// import 'package:proequine/screens/main_screen.dart';
// import 'package:proequine/screens/user_profile.dart';
// import 'package:proequine/screens/evnets/events_list.dart';
//
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     MainScreen(),
//     ServicesDetails(),
//     EventList(),
//     // UserProfile(),
//     BookEvent()
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBody: true,
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'Services',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event_available),
//             label: 'Event',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle_rounded),
//             label: 'profile',
//             backgroundColor: Colors.black,
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         unselectedItemColor: Colors.white,
//         selectedItemColor: Color.fromRGBO(196, 134, 54, 1),
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
