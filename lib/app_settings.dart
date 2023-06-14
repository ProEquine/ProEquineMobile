import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class AppSettings {
  static Future setup() async {
    String? url = await SecureStorage().getUrl();
    baseUrl = url ?? "https://pet-webapi-uaeno-dev-001.azurewebsites.net";
  }

  static String baseUrl = AppSharedPreferences.getEnvType;
  static const String version = '1.0.0.6';
}
