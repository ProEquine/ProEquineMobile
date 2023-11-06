import '../../app_settings.dart';

class ApiURLs {
  static  String baseUrl = AppSettings.baseUrl;

  static  String basicApiUrl = "$baseUrl/api";

  /// Auth URLs
  static  String loginUSER = "$baseUrl/Auth/login";
  static  String registerUSER = "$baseUrl/User/userRegister";
  static  String getNewToken = "$baseUrl/Auth/refreshToken";
  static  String sendVerificationCode = "$baseUrl/User/sendPhoneOtp";

  static  String updateUserName = "$baseUrl/User/updateUserName";
  static  String updateName = "$baseUrl/Account/updateName";
  static  String forgotPassword = "$baseUrl/Master/ForgotPassword";
  static  String updateNationality = "$baseUrl/Account/updateNationality";
  static  String updateDOB = "$baseUrl/Account/updateDOB";
  static  String checkVerificationCode = "$basicApiUrl/Auth/checkverificationcode";
  // static  String forgotPassword = "$basicApiUrl/Auth/forgot-password";
  static  String interests = "$baseUrl/User/saveInterestandType";
  static  String getStables = "$baseUrl/Master/getMainStables";
  static  String getDisciplines = "$baseUrl/Master/getAllDisciplines";
  static  String choseStables = "$baseUrl/User/SaveMainStable";


 /// Account information
  static  String getUserDiscipline = "$baseUrl/Account/getUserDisciplines";
  static  String getUserStables = "$baseUrl/Account/getUserStables";
  static  String getUserRoles = "$baseUrl/Account/getRoles";
  static  String updateMainDiscipline = "$baseUrl/Account/updateMainDiscipline";
  static  String updateMainStable = "$baseUrl/Account/updateMainStable";
  static  String addSecondaryDiscipline = "$baseUrl/Account/addSecondaryDiscipline";
  static  String addSecondaryStable = "$baseUrl/Account/addSecondaryStable";
  static  String addRole = "$baseUrl/Account/addRole";
  static  String deleteRole = "$baseUrl/Account/deleteRole";
  static  String resetPassword = "$baseUrl/Account/resetPassword";
  static  String updateSecondaryDiscipline = "$baseUrl/Account/updateSecondaryDiscipline";
  static  String deleteDiscipline = "$baseUrl/Account/removeSecondaryDiscipline";
  static  String deleteStable = "$baseUrl/Account/removeSecondaryStable";
  static  String changePassword = "$baseUrl/Account/updatePassword";
  static  String addBio = "$baseUrl/Account/addBioAndSocialMediaAccount";
  static  String uploadImage = "$baseUrl/Account/addUserImage";
  static  String sendPhone = "$basicApiUrl/User/editphonenumber";
  static  String updatePhone = "$baseUrl/Account/updateMainPhoneNumber";
  static  String updateSecondaryPhone = "$baseUrl/Account/updateSecondaryNumber";
  static  String addSecondaryNumber = "$baseUrl/Account/addSecondaryNumber";
  static  String addAddress = "$baseUrl/Account/addAddress";
  static  String contactSupport = "$baseUrl/Account/createSupportRequest";
  static  String getUserData = "$baseUrl/Account/getUserData";
  static  String sendVerificationEmail = "$baseUrl/Master/sendEmailVerificationCode";
  static  String checkVerificationEmail = "$baseUrl/Master/checkEmailVerificationCode";
  static  String updateMail = "$basicApiUrl/User/editemailaddress";
  static  String checkUpdateMail = "$baseUrl/Account/updateEmailAddress";
  static  String deleteUser = "$baseUrl/Account/deleteAccount";



  /// Events URLs
  static  String allEvents = "$baseUrl/MobileApp/GetEvents";


  /// Horses URLs

  static  String addHorse = "$baseUrl/api/Horse/addHorse";
  static  String updateHorse = "$baseUrl/api/Horse/updateHorse";
  static  String getHorses = "$baseUrl/api/Horse/getUserHorses";
  static  String updateHorseCondition = "$baseUrl/api/Horse/updateHorseCondition";

}
