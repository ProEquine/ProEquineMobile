// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class LocalNotification {
//   static Int64List vibrationPattern =
//
//   Int64List.fromList([500, 1000]);
//
//   /// Create a [AndroidNotificationChannel] for heads up notifications
//
//   static AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     vibrationPattern: vibrationPattern,
//     showBadge: true,
//     enableLights: true,
//
//      // sound: RawResourceAndroidNotificationSound('arrive'),
//   );
//
//   /// Initialize the [FlutterLocalNotificationsPlugin] package.
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static initializeLocalNotification(
//       {required void Function(Map<String, dynamic> data) onNotificationPressed,
//         String? icon}) async {
//     // Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings(icon!);
//     final DarwinInitializationSettings initializationSettingsDarwin =
//      DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,iOS: initializationSettingsDarwin);
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onSelectNotification: (payload) {
//       //   return onSelectNotification(
//       //       payload: payload, onData: onNotificationPressed);
//       // },
//     );
//
//   }
//
//   static Future onSelectNotification({String? payload, onData}) async {
//     if (payload != null) {
//      // debugPrint('notification payload: $payload');
//       print('notification payload: $payload');
//
//       var jsonData = jsonDecode(payload);
//       onData(jsonData);
//     }
//   }
//
//   static Future onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     print(title);
//   }
//
//   static showNotification(
//       {RemoteNotification? notification,
//         required Map<String, dynamic> payload,String? icon}) {
//     flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification?.title,
//         notification?.body,
//         NotificationDetails(
//           // iOS: IOSNotificationDetails(
//           //   // sound: 'arrive',
//           // ),
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//           channelDescription:  channel.description,
//             icon: icon,
//             priority: Priority.max,
//             importance: Importance.max,
//             visibility: NotificationVisibility.public,
//             channelShowBadge: true,
//             playSound: true,
//             vibrationPattern: vibrationPattern,
//             enableVibration: true,
//             enableLights: true,
//
//           ),
//         ),
//         payload: jsonEncode(payload));
//     // }
//   }
//
//   void onNotificationPressed(String payload) {
//     print('onNotificationPressed $payload');
//     final jsonPayload = jsonDecode(payload);
//   }
// }
