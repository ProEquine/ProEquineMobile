import '../printer.dart';
import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  //todo move these to constants
  static const keyAccessToken = "PREF_KEY_ACCESS_TOKEN";
  static const keyUserId = "PREF_KEY_USER_ID";
  static const keyRefreshToken = "PREF_KEY_REFRESH_TOKEN";
  static const keyDeviceId = "PREF_KEY_DEVICE_ID";
  static const keyFirstTime = "PREF_KEY_FIRST_TIME";
  static const keyLanguage = "PREF_KEY_LANGUAGE";

  static bool? initialized;
  static SharedPreferencesProvider? _pref;

  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }

  static clear() {
    _pref?.clear();
  }

  static clearForLogOut() {
    removeAccessToken();
    removeAccessTokenFirebase();
  }

  /// AccessToken
  static String get accessToken => _pref?.read(keyAccessToken) ?? '';

  static set accessToken(String accessToken) =>
      _pref?.save(keyAccessToken, accessToken);

  static bool get hasAccessToken => _pref?.contains(keyAccessToken) ?? false;

  static removeAccessToken() => _pref?.remove(keyAccessToken);

  /// User Id
  static String get userId => _pref?.read(keyUserId) ?? '';

  static set userId(String userId) =>
      _pref?.save(keyUserId, userId);

  static removeUserId() => _pref?.remove(keyUserId);

  /// RefreshToken
  static String? get refreshToken => _pref?.read(keyRefreshToken) ?? '';

  static set refreshToken(String? refreshToken) =>
      _pref?.save(keyRefreshToken, refreshToken);

  static bool get hasRefreshToken => _pref?.contains(keyRefreshToken);

  static removeRefreshToken() => _pref?.remove(keyRefreshToken);




  ///  Device id for one signal
  static String get deviceID => _pref?.read(keyDeviceId) ?? '';

  static set deviceId(String deviceId) => _pref?.save(keyDeviceId, deviceId);

  static bool get hasDeviceId => _pref?.contains(keyDeviceId);

  static removeAccessTokenFirebase() => _pref?.remove(keyDeviceId);


  ///Language
  static String get lang {
    String? lang = _pref?.read(keyLanguage);
    if(lang == null || lang.isEmpty){
      return 'en';
    }else{
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
}
