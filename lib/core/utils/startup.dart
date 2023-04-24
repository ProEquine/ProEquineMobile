import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class StartUp {
  static void setup() async {
    // ServiceLocator.registerModels();
    await AppSharedPreferences.init();
    // AppSharedPreferences.clear();
    //await LocalNotification.initializeLocalNotification();
  }
}
