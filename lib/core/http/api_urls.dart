import '../../app_settings.dart';

class ApiURLs {
  static const String baseUrl = AppSettings.baseUrl;

  static const String basicApiUrl = "$baseUrl/api";

  /// Auth URLs
  static const String loginUSER = "$basicApiUrl/Auth/login";
  static const String registerUSER = "$basicApiUrl/Auth/userregister";
  static const String getNewToken = "$basicApiUrl/Auth/refresh";
  static const String sendVerificationCode = "$basicApiUrl/Auth/sendverificationcode";
  static const String checkVerificationCode = "$basicApiUrl/Auth/checkverificationcode";
  static const String forgotPassword = "$basicApiUrl/Auth/forgot-password";
  static const String resetPassword = "$basicApiUrl/Auth/reset-password";
  static const String interests = "$basicApiUrl/Auth/saveinterestandtype";



  /// Events URLs
  static const String allEvents = "$baseUrl/MobileApp/GetEvents";


  /// Profile URLs
  static const String changePassword = "$basicApiUrl/Auth/resetpasswordfromprofile";
  static const String sendPhone = "$basicApiUrl/User/editphonenumber";
  static const String updatePhone = "$basicApiUrl/User/updatephonenumber";
  static const String contactSupport = "$basicApiUrl/User/supportquery";
  static const String getUserData = "$basicApiUrl/User/getuserdata";
  static const String sendVerificationEmail = "$basicApiUrl/User/sendemailverificationcode";
  static const String checkVerificationEmail = "$basicApiUrl/User/checkemailverificationcode";
  static const String updateMail = "$basicApiUrl/User/editemailaddress";
  static const String checkUpdateMail = "$basicApiUrl/User/updateemailaddress";
  static const String deleteUser = "$basicApiUrl/User/deleteaccount";

}
