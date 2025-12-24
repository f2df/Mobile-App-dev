import 'package:shared_preferences/shared_preferences.dart';

import 'app_preference_key.dart';

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences({required this.sharedPreferences});

  Future<bool> _saveString(String key, String? value) {
    return sharedPreferences.setString(key, value ?? "");
  }

  Future<bool> _saveStringList(String key, List<String> value) {
    return sharedPreferences.setStringList(key, value);
  }

  List<String>? _getListString(
    String key,
  ) {
    return sharedPreferences.getStringList(key) ?? [];
  }

  String? _getString(String key, {String defaultValue = ""}) {
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  Future<bool> _saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  bool getBoolean(String key, {bool defaultValue = false}) {
    return sharedPreferences.getBool(key) ?? false;
  }

  int _saveInt(String key, {int defaultValue = 0}) {
    final str = _getString(key, defaultValue: defaultValue.toString());
    final value = int.tryParse(str!);
    if (value != null) {
      return value;
    }
    return defaultValue;
  }
  int getInt(String key, {int defaultValue = 0}) {
    return sharedPreferences.getInt(key) ?? 0;
  }

  Future<void> saveEmail(String email) {
    return _saveString(AppPreferenceKey.keyEmail, email);
  }

  String get email {
    return _getString(AppPreferenceKey.keyEmail, defaultValue: "")!;
  }

  Future<void> saveAuthToken(String toke) {
    return _saveString(AppPreferenceKey.authToken, toke);
  }

  String get authToken {
    return _getString(AppPreferenceKey.authToken, defaultValue: "")!;
  }

  Future<void> saveUserId(String userId) {
    return _saveString(AppPreferenceKey.userId, userId);
  }

  String get userId {
    return _getString(AppPreferenceKey.userId, defaultValue: "")!;
  }

  Future<void> saveUserImage(String userImage) {
    return _saveString(AppPreferenceKey.userImage, userImage);
  }

  String get userImage {
    return _getString(AppPreferenceKey.userImage, defaultValue: "")!;
  }

  Future<void> saveUserName(String userName) {
    return _saveString(AppPreferenceKey.userName, userName);
  }

  String get userName {
    return _getString(AppPreferenceKey.userName, defaultValue: "")!;
  }
  Future<void> saveAddress1(String userName) {
    return _saveString(AppPreferenceKey.address1, userName);
  }

  String get address_1 {
    return _getString(AppPreferenceKey.address1, defaultValue: "")!;
  }
  Future<void> saveAddress2(String userName) {
    return _saveString(AppPreferenceKey.address2, userName);
  }

  String get address_2 {
    return _getString(AppPreferenceKey.address2, defaultValue: "")!;
  }
  Future<void> savePinPCode(String userName) {
    return _saveString(AppPreferenceKey.pinPcode, userName);
  }

  String get pinPCode {
    return _getString(AppPreferenceKey.pinPcode, defaultValue: "")!;
  }
  Future<void> savePCity(String userName) {
    return _saveString(AppPreferenceKey.pCity, userName);
  }

  String get pCity {
    return _getString(AppPreferenceKey.pCity, defaultValue: "")!;
  }
  Future<void> savePState(String userName) {
    return _saveString(AppPreferenceKey.pstate, userName);
  }

  String get pState {
    return _getString(AppPreferenceKey.pstate, defaultValue: "")!;
  }
  Future<void> saveHouseNo(String userName) {
    return _saveString(AppPreferenceKey.houseNo, userName);
  }


  String get houseNo {
    return _getString(AppPreferenceKey.houseNo, defaultValue: "")!;
  }
  Future<void> saveStreet(String userName) {
    return _saveString(AppPreferenceKey.street, userName);
  }

  String get street {
    return _getString(AppPreferenceKey.street, defaultValue: "")!;
  }

  Future<void> saveArea(String userName) {
    return _saveString(AppPreferenceKey.area, userName);
  }

  String get area {
    return _getString(AppPreferenceKey.area, defaultValue: "")!;
  }

  Future<void> saveLandmark(String userName) {
    return _saveString(AppPreferenceKey.landmark, userName);
  }

  String get landmark {
    return _getString(AppPreferenceKey.landmark, defaultValue: "")!;
  }

  Future<void> saveCity(String userName) {
    return _saveString(AppPreferenceKey.city, userName);
  }

  String get city {
    return _getString(AppPreferenceKey.city, defaultValue: "")!;
  }

  Future<void> saveState(String userName) {
    return _saveString(AppPreferenceKey.state, userName);
  }

  String get state {
    return _getString(AppPreferenceKey.state, defaultValue: "")!;
  }
  Future<void> saveCountry(String userName) {
    return _saveString(AppPreferenceKey.state, userName);
  }

  String get country {
    return _getString(AppPreferenceKey.state, defaultValue: "")!;
  }

  Future<void> saveAddress(String address) {
    return _saveString(AppPreferenceKey.address, address);
  }

  String get address {
    return _getString(AppPreferenceKey.address, defaultValue: "")!;
  }
  Future<void> savePinCode(String address) {
    return _saveString(AppPreferenceKey.pinCode, address);
  }

  String get pinCode {
    return _getString(AppPreferenceKey.pinCode, defaultValue: "")!;
  }

  Future<void> saveImg(String img) {
    return _saveString(AppPreferenceKey.img, img);
  }

  String get profileImage {
    return _getString(AppPreferenceKey.img, defaultValue: "")!;
  }

  Future<void> saveMobile(String mobile) {
    return _saveString(AppPreferenceKey.mobile, mobile);
  }

  String get mobile {
    return _getString(AppPreferenceKey.mobile, defaultValue: "")!;
  }

  Future<void> saveReferralCode(String refferalCode) {
    return _saveString(AppPreferenceKey.refferalCode, refferalCode);
  }

  String get refferalCode {
    return _getString(AppPreferenceKey.refferalCode, defaultValue: "")!;
  }

  Future<void> saveLoggedIn(bool loggedIn) {
    return _saveBoolean(AppPreferenceKey.loggedIn, loggedIn);
  }

  bool get isSaveAddress {
    return getBoolean(AppPreferenceKey.delivaryAddress);
  }
  Future<void> saveDelivaryAddress(bool delivaryAddress) {
    return _saveBoolean(AppPreferenceKey.delivaryAddress, delivaryAddress);
  }
  int saveDelivaryAddressId(int delivaryAddressId) {
    return _saveInt(AppPreferenceKey.delivaryAddress, defaultValue: delivaryAddressId);
  }

  bool get isLoggedIn {
    return getBoolean(AppPreferenceKey.loggedIn);
  }

  Future<void> saveUserExit(bool userExist) {
    return _saveBoolean(AppPreferenceKey.userExist, userExist);
  }

  bool get isUserExist {
    return getBoolean(AppPreferenceKey.userExist);
  }
  Future<void> savePopUp(bool showPopUp) {
    return _saveBoolean(AppPreferenceKey.showPopUp, showPopUp);
  }

  bool get isShow {
    return getBoolean(AppPreferenceKey.showPopUp);
  }

  /*bool get userName {
    return _getInt(AppPreferenceKey.loggedIn,defaultValue: false)!;
  }*/
  Future<void> saveStoreId(String userId) {
    return _saveString(AppPreferenceKey.storeId, userId);
  }

  String get storeId {
    return _getString(AppPreferenceKey.storeId, defaultValue: "0")!;
  }

  Future<void> saveBanner(List<String> banner) {
    return _saveStringList(AppPreferenceKey.banner, banner);
  }

  List<String> get banner {
    return _getListString(AppPreferenceKey.banner)!;
  }

  Future<void> saveTutorialShow(bool tutorialShow) {
    return _saveBoolean(AppPreferenceKey.tutorialShow, tutorialShow);
  }

  bool get isTutorialShow {
    return getBoolean(AppPreferenceKey.tutorialShow);
  }

  void logOut() {
    saveLoggedIn(false);
    saveUserName("");
    saveUserImage("");
    saveEmail("");
    savePinCode("");
    saveAddress("");
    saveAddress1("");
    saveAddress2("");
    saveArea("");
    saveAuthToken("");
    saveCity("");
    saveCountry("");
    saveEmail("");
    saveHouseNo("");
    saveLandmark("");
    saveImg("");
    saveMobile("");
    savePCity("");
    savePinPCode("");
    savePinCode("");
    savePState("");
    saveUserId("");
    saveState("");
    saveDelivaryAddress(false);
  }
}
