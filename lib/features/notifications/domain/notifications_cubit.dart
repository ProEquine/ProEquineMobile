
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:proequine/features/notifications/data/saved_notification_data.dart';
import 'package:proequine/main.dart';
import '../../../core/constants/routes/routes.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../nav_bar/domain/inbox_badge.dart';


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
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent notification) {
      Print("Message received");
      BlocProvider.of<ChangeBoolCubit>(MyApp.navigatorKey.currentContext!).changeStatusToTrue();
    });

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      try {
        final data = result.notification.additionalData;
        SavedNotificationData.notificationData= result.notification.additionalData;
        Print("saved data from notification ${SavedNotificationData.notificationData}");

        Print("data ${data}");
        final payload = data!['Navigate'];
        final navigate = payload.toString();

        Print("payload ${payload.toString()}");
        getNavigationKey(navigate);

      } catch (e, stacktrace) {
        Print("e $e");
      }
    });

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
void getNavigationKey(String key){
  print("key $key");
  if (key == "Bookings") {

    MyApp.navigatorKey.currentState?.pushNamed(bookingRoute);
  }

}
