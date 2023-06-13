import '../../app_settings.dart';

class ApiURLs {
  static  String baseUrl = AppSettings.baseUrl;

  static  String basicApiUrl = "$baseUrl/api";

  /// Auth URLs
  static  String loginUSER = "$basicApiUrl/Auth/login";
  static  String registerUSER = "$basicApiUrl/Auth/userregister";
  static  String getNewToken = "$basicApiUrl/Auth/refresh";
  static  String sendVerificationCode = "$basicApiUrl/Auth/sendverificationcode";
  static  String checkVerificationCode = "$basicApiUrl/Auth/checkverificationcode";
  static  String forgotPassword = "$basicApiUrl/Auth/forgot-password";
  static  String resetPassword = "$basicApiUrl/Auth/reset-password";
  static  String interests = "$basicApiUrl/Auth/saveinterestandtype";



  /// Events URLs
  static  String allEvents = "$baseUrl/MobileApp/GetEvents";


  /// Profile URLs
  static  String changePassword = "$basicApiUrl/Auth/resetpasswordfromprofile";
  static  String sendPhone = "$basicApiUrl/User/editphonenumber";
  static  String updatePhone = "$basicApiUrl/User/updatephonenumber";
  static  String contactSupport = "$basicApiUrl/User/supportquery";
  static  String getUserData = "$basicApiUrl/User/getuserdata";
  static  String sendVerificationEmail = "$basicApiUrl/User/sendemailverificationcode";
  static  String checkVerificationEmail = "$basicApiUrl/User/checkemailverificationcode";
  static  String updateMail = "$basicApiUrl/User/editemailaddress";
  static  String checkUpdateMail = "$basicApiUrl/User/updateemailaddress";
  static  String deleteUser = "$basicApiUrl/User/deleteaccount";

}
