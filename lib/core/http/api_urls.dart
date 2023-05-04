import '../../app_settings.dart';

class ApiURLs {
  static const String baseUrl = AppSettings.baseUrl;

  static const String basicApiUrl = "$baseUrl/api";

  /// Auth URLs
  static const String loginUSER = "$basicApiUrl/Auth/login";
  static const String registerUSER = "$basicApiUrl/Auth/register";
  static const String getNewToken = "$basicApiUrl/Auth/refresh";


  /// Events URLs
  static const String allEvents = "$baseUrl/MobileApp/GetEvents";

}
