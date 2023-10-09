import '../../app_settings.dart';

class ApiURLs {
  static  String baseUrl = AppSettings.baseUrl;

  static  String basicApiUrl = "$baseUrl/api";

  /// Auth URLs
  static  String loginUSER = "$baseUrl/login";
  static  String registerUSER = "$baseUrl/User/userRegister";
  static  String getNewToken = "$baseUrl/refreshToken";
  static  String sendVerificationCode = "$baseUrl/User/sendPhoneOtp";
  static  String updateUserName = "$baseUrl/User/updateUserName";
  static  String checkVerificationCode = "$basicApiUrl/Auth/checkverificationcode";
  static  String forgotPassword = "$basicApiUrl/Auth/forgot-password";
  static  String resetPassword = "$basicApiUrl/Auth/reset-password";
  static  String interests = "$baseUrl/User/saveInterestandType";
  static  String getStables = "$baseUrl/getMainStable";



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
