// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import '../utils/printer.dart';
// import 'LocalNotification.dart';
//
// class FCM {
//   static ValueChanged<String>? onTokenChanged;
//   static String? token = '';
//
//   static initializeFCM(
//       {required void Function(String token) onTokenChanged,
//       required void Function(Map<String, dynamic> data) onNotificationPressed,
//       String? icon}) async {
//     FCM.onTokenChanged = onTokenChanged;
//     await LocalNotification.initializeLocalNotification(
//         onNotificationPressed: onNotificationPressed, icon: icon!);
//     await Firebase.initializeApp();
//     await FirebaseMessaging.instance.getToken().then((newToken) {
//       Print("FCm Token$newToken");
//       Print(newToken);}
//     );
//
//     Stream<String> _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
//     _tokenStream.listen(onTokenChanged);
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       print('getInitialMessage');
//       print(message);
//
//       if (message != null) {
//         Timer.periodic(
//           Duration(milliseconds: 10000),
//           (timer) {
//             //   if (gNavigationService.navigationKey.currentState == null) return;
//
//             onNotificationPressed(message.data);
//
//             timer.cancel();
//           },
//         );
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       Print('A new onMessage event was published!');
//
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         LocalNotification.showNotification(
//             notification: notification, payload: message.data, icon: icon);
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       onNotificationPressed(message.data);
//     });
//
//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       print('A new onBackgroundMessage event was published!');
//       onNotificationPressed(message.data);
//     });
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     // If you're going to use other Firebase services in the background, such as Firestore,
//     // make sure you call `initializeApp` before using other Firebase services.
//     await Firebase.initializeApp();
//     print('Handling a background message ${message.messageId}');
//   }
//
//   static refreshToken() async {
//     await FirebaseMessaging.instance.deleteToken();
//     await FirebaseMessaging.instance
//         .getToken()
//         .then((value) => Print("Changed"));
//   }
// }
