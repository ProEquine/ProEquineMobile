

import '../notification/Notification.dart';
import '../utils/secure_storage/secure_storage_helper.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class StartUp
{
  static void setup()async {
    // ServiceLocator.registerModels();
    await AppSharedPreferences.init();
    // AppSharedPreferences.clear();
    //await LocalNotification.initializeLocalNotification();


   // await Messaging.initFCM();

  }
}
