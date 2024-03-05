import '../../app_settings.dart';

class ApiURLs {
  static  String baseUrl = AppSettings.baseUrl;

  static  String basicApiUrl = "$baseUrl/v1";

  /// Auth URLs
  static  String loginUSER = "$basicApiUrl/auth/login";
  static  String registerUSER = "$basicApiUrl/auth/signUp";
  static  String getNewToken = "$basicApiUrl/auth/refresh-token";
  static  String sendVerificationCode = "$basicApiUrl/auth/ask-for-verify-phone-number-otp";

  static  String updateUserName = "$basicApiUrl/auth/update-userName";
  static  String updateName = "$basicApiUrl/Account/updateName";
  static  String forgotPassword = "$basicApiUrl/auth/ask-for-forget-password-otp";
  static  String updateNationality = "$basicApiUrl/Account/updateNationality";
  static  String updateDOB = "$basicApiUrl/Account/updateDOB";
  static  String checkVerificationCode = "$basicApiUrl/auth/confirm-verify-phone-number";
  static  String resetPassword = "$basicApiUrl/auth/confirm-forget-password";
  static  String interests = "$basicApiUrl/auth/update-roles-and-disciplines";

  static  String getDisciplines = "$basicApiUrl/Master/getAllDisciplines";
  static  String choseStables = "$basicApiUrl/auth/update-stable";


 /// Account information
  static  String getUserDiscipline = "$basicApiUrl/userDisciplines";
  static  String getUserStables = "$basicApiUrl/userStables";
  static  String uploadFile = "$basicApiUrl/upload";
  static  String updateImage = "$basicApiUrl/auth/update-image";
  static  String getUserRoles = "$baseUrl/Account/getRoles";
  static  String updateMainDiscipline = "$baseUrl/Account/updateMainDiscipline";
  static  String updateMainStable = "$baseUrl/Account/updateMainStable";
  static  String addSecondaryDiscipline = "$basicApiUrl/userDisciplines";
  static  String addSecondaryStable = "$basicApiUrl/userStables";
  static  String addNewStable = "$basicApiUrl/stables";
  static  String addRole = "$baseUrl/Account/addRole";
  static  String deleteRole = "$baseUrl/Account/deleteRole";

  static  String updateSecondaryDiscipline = "$basicApiUrl/Account/updateSecondaryDiscipline";
  static  String deleteDiscipline = "$basicApiUrl/Account/removeSecondaryDiscipline";
  static  String deleteStable = "$basicApiUrl/userStables";
  static  String changePassword = "$basicApiUrl/auth/reset-password";
  static  String addBio = "$basicApiUrl/Account/addBioAndSocialMediaAccount";
  static  String sendPhone = "$basicApiUrl/auth/ask-change-phone-number-otp";
  static  String updatePhone = "$basicApiUrl/auth/confirm-change-phone-number-otp";
  static  String updateSecondaryPhone = "$basicApiUrl/auth/update-second-number";
  static  String addSecondaryNumber = "$basicApiUrl/Account/addSecondaryNumber";
  static  String addAddress = "$basicApiUrl/auth/update-address";
  static  String contactSupport = "$basicApiUrl/supportRequests";
  static  String getUserData = "$basicApiUrl/auth/my-profile";
  static  String getStates = "$basicApiUrl/Master/getStates";
  static  String getCities = "$basicApiUrl/Master/getCities";
  static  String sendVerificationEmail = "$basicApiUrl/auth/ask-for-verify-email-otp";
  static  String sendUpdateVerificationEmail = "$basicApiUrl/auth/ask-change-email";
  static  String checkVerificationEmail = "$basicApiUrl/auth/confrim-verify-email";
  static  String updateMail = "$basicApiUrl/User/editemailaddress";
  static  String checkUpdateMail = "$basicApiUrl/auth/confrim-verify-email";
  static  String deleteUser = "$basicApiUrl/Account/deleteAccount";



  /// Events URLs
  static  String allEvents = "$baseUrl/MobileApp/GetEvents";


  /// Horses URLs

  static  String addHorse = "$basicApiUrl/horses";
  static  String invitesAssociations = "$basicApiUrl/horseAssociations/user/invite";
  static  String requestAssociations = "$basicApiUrl/horseAssociations/user/request";
  static  String horseAssociation = "$basicApiUrl/horseAssociations";
  static  String horseAssociationApprove = "$basicApiUrl/horseAssociations/approve";
  static  String horseAssociationReject = "$basicApiUrl/horseAssociations/reject";
  static  String updateHorse = "$baseUrl/api/Horse/updateHorse";
  static  String getHorses = "$basicApiUrl/horses/user";
  static  String updateHorseCondition = "$baseUrl/api/Horse/updateHorseCondition";
  static  String removeHorse = "$basicApiUrl/horses";
  static  String verifyHorse = "$basicApiUrl/horses/verification-document";
  ///horses docs
  static  String addHorseDocument = "$basicApiUrl/horseDocuments/";
  static  String editHorseDocument = "$basicApiUrl/horseDocuments/";
  static  String removeHorseDocument = "$basicApiUrl/horseDocuments/delete";
  static  String allDocuments = "$basicApiUrl/horseDocuments/horse-documents";

  /// stables APIs

  static  String getStables = "$basicApiUrl/stables/public";

  /// support request
  static  String getAllRequests = "$basicApiUrl/supportRequests/user";
}
