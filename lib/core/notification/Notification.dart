// import 'package:flutter/material.dart';
// import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
// import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
// import '../../main.dart';
// import '../utils/Printer.dart';
// import './FCM.dart';
//
// class Messaging {
//
//   static String? token;
//   static initFCM()async{
//     try{
//       await FCM.initializeFCM(
//           onNotificationPressed: (Map<String, dynamic> data) {
//             Navigator.of(MyApp.navigatorKey.currentContext!).pushReplacement(MaterialPageRoute(builder: (context)=>BottomNavigation()));
//           },
//           onTokenChanged: (String token) async{
//             Messaging.token = token;
//             Print("FCmmmmmmm Token is ${AppSharedPreferences.deviceID}");
//             AppSharedPreferences.deviceId =  token;
//             // await _updateFCMToken(AppSharedPreferences.fcmToken!);
//           },
//           icon: 'ic_stat_fiber_new'
//       );
//     }catch(e){}
//   }
// }
//
//
// ///------------------------Firebase--------------------------///
// // Future<bool> _updateFCMToken(String? fcmToken) async {
// //   Print("fcmToken_fcmToken"+fcmToken!+"fcmToken_fcmToken");
// //   final result = await NotificationRepository
// //       .changeFirebaseToken(fcmToken);
// //   if(result is EmptyModel){
// //     return true;
// //   }else{
// //     await NotificationRepository.changeFirebaseToken(fcmToken);
// //   }
// // }
