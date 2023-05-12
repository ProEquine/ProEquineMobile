import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  //todo move these to constants
  static const keyAccessToken = "PREF_KEY_ACCESS_TOKEN";
  static const keyUserId = "PREF_KEY_USER_ID";
  static const keyRefreshToken = "PREF_KEY_REFRESH_TOKEN";
  static const keyDeviceId = "PREF_KEY_DEVICE_ID";
  static const keyFirstTime = "PREF_KEY_FIRST_TIME";
  static const keyLanguage = "PREF_KEY_LANGUAGE";
  static const keyUserPhoneNumber = "PREF_KEY_USER_PHONE_NUMBER";
  static const keyUserType = "PREF_KEY_USER_TYPE";
  static const keyUserInterests = "PREF_KEY_INTERESTS";

  static const keyIsPhoneVerified = "PREF_KEY_VERIFICATION_PHONE";
  static const keyIsEmailVerified = "PREF_KEY_VERIFICATION_EMAIL";

  static bool? initialized;
  static SharedPreferencesProvider? _pref;

  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }

  static clear() {
    _pref?.clear();
  }

  static clearForLogOut() {
    removeTypeSelected();
    removePhoneVerified();
  }
  ///  Store User Phone Number
  static String get userPhoneNumber => _pref?.read(keyUserPhoneNumber) ?? '';

  static set inputPhoneNumber(String phoneNumber) => _pref?.save(keyUserPhoneNumber, phoneNumber);

  static bool get hasPhoneNumber => _pref?.contains(keyUserPhoneNumber);

  static removePhoneNumber() => _pref?.remove(keyUserPhoneNumber);

  ///Language
  static String get lang {
    String? lang = _pref?.read(keyLanguage);
    if (lang == null || lang.isEmpty) {
      return 'en';
    } else {
      return lang;
    }
  }

  static set lang(String lang) => _pref?.save(keyLanguage, lang);

  ///FIRST_TIME Starting Application
  static bool? get getFirstTime {
    if (_pref?.readBoolean(keyFirstTime) == null) firstTime = false;

    return _pref?.readBoolean(keyFirstTime) ?? false;
  }

  static set firstTime(bool? first) =>
      _pref?.saveBoolean(keyFirstTime, first) ?? false;

  /// is phone number verified
  static bool? get getPhoneVerified {
    if (_pref?.readBoolean(keyIsPhoneVerified) == null) phoneVerified = false;

    return _pref?.readBoolean(keyIsPhoneVerified) ?? false;
  }

  static set phoneVerified(bool? verified) =>
      _pref?.saveBoolean(keyIsPhoneVerified, verified) ?? false;
  static removePhoneVerified() => _pref?.remove(keyIsPhoneVerified);

  /// is email number verified
  static bool? get getEmailVerified {
    if (_pref?.readBoolean(keyIsEmailVerified) == null) emailVerified = false;

    return _pref?.readBoolean(keyIsEmailVerified) ?? false;
  }

  static set emailVerified(bool? verified) =>
      _pref?.saveBoolean(keyIsEmailVerified, verified) ?? false;

  /// is user select the interests
  static bool? get getIsInterestsSelected {
    if (_pref?.readBoolean(keyUserInterests) == null) selectedInterests = false;

    return _pref?.readBoolean(keyUserInterests) ?? false;
  }

  /// is user type selected
  static set selectedInterests(bool? interests) =>
      _pref?.saveBoolean(keyUserInterests, interests) ?? false;

  static bool? get getIsITypeSelected {
    if (_pref?.readBoolean(keyUserType) == null) typeSelected = false;

    return _pref?.readBoolean(keyUserType) ?? false;
  }
  static removeTypeSelected() => _pref?.remove(keyUserType);
  static set typeSelected(bool? type) =>
      _pref?.saveBoolean(keyUserType, type) ?? false;
}
