
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  void configOneSignal() async {
    await OneSignal.shared.setAppId('ef8bd521-54d4-4a21-b1f3-654755149b50');

    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    Print("Device ID ${osUserID.toString()}");
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      //  print(changes.to.userId);
      String? userId = changes.to.userId ?? '';
      if (userId != '') {
        AppSharedPreferences.setDeviceId = userId.toString();
      }
    });
    AppSharedPreferences.setDeviceId = osUserID!.toString();

    Print("Device Id From Shared Pref ${AppSharedPreferences.getDeviceId}");

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});

    /// Calls when the notification opens the app.
    // OneSignal.shared.setNotificationOpenedHandler(handleBackgroundNotification);

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      Print("Accepted permission: $accepted");
    });
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  }
}
