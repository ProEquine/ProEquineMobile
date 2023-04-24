import 'package:proequine/core/utils/rebi_message.dart';

class WillPop{
 static DateTime? currentBackPressTime;

  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      RebiMessage.warning(msg: "Press back again to quit the app");
      return Future.value(false);
    }
    return Future.value(true);
  }
}