import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ssi_logger.dart';

class AppState {
  static String token_Key = 'token_Key';
  static const _privacyAgreeStatus_key = '_privacyAgreeStatus_key';
  static const _username_key = '_username_key';
  static const _password_key = '_password_key';
  static const _rememberPassword_key = '_rememberPassword_key';


  String token = "";

  var rememberPassword = false;

  // 登录记住的用户名和密码
  String userName = "";
  String password = "";

  /// 用户同意隐私状态 -1: unknow , 0 : 未同意 ， 1 ： 已同意
  int _privacyAgreeStatus = -1;

  int get privacyAgreeStatus {
    return _privacyAgreeStatus;
  }

  isLogin() {
    return token.isNotEmpty;
  }

  AppState() {
    SsiLogger.d('AppState init');
  }

  readSharedPreferencesData() async {
    await _readData();
  }

  void setToken(String token) {
    this.token = token;
    saveData();
  }

  void setRememberPassword(bool remember) async {
    rememberPassword = remember;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_rememberPassword_key, remember);
  }

  void setPrivacyAgreeStatus(bool agree) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_privacyAgreeStatus_key, agree ? 1 : 0);
    _privacyAgreeStatus = agree ? 1 : 0;
  }

  loginSuccess(String token, {String? userName,String? password}) {
    this.token = token;
    this.userName = userName ?? '';
    saveData(userName: userName, password: password);
  }

  logout() {
    token = "";
    saveData();
    _clearLoginData();
  }

  // 保存数据
  saveData({String? userName, String? password}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(token_Key, token);
    if (userName != null) {
      prefs.setString(_username_key, userName);
    }
    if (password != null) {
      prefs.setString(_password_key, password);
    }
  }

  void _clearLoginData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(token_Key);
  }

  clearAllData() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(token_Key);
    prefs.remove(_username_key);
    prefs.remove(_privacyAgreeStatus_key);
  }

  _readData() async {
    var prefs = await SharedPreferences.getInstance();
    token = prefs.getString(token_Key) ?? "";
    userName = prefs.getString(_username_key) ?? "";
    password = prefs.getString(_password_key) ?? "";
    _privacyAgreeStatus = prefs.getInt(_privacyAgreeStatus_key) ?? -1;
    rememberPassword = prefs.getBool(_rememberPassword_key) ?? false;
  }
}