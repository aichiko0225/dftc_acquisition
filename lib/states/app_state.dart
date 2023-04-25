import 'package:shared_preferences/shared_preferences.dart';

import '../utils/ssi_logger.dart';

class AppState {
  static String token_Key = 'token_Key';
  static const _privacyAgreeStatus_key = '_privacyAgreeStatus_key';
  static const _username_key = '_username_key';

  String token = "";

  // 登录记住的用户名和密码
  String username = "";

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

  void setPrivacyAgreeStatus(bool agree) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_privacyAgreeStatus_key, agree ? 1 : 0);
    _privacyAgreeStatus = agree ? 1 : 0;
  }

  loginSuccess(String token, {String? phoneNum}) {
    this.token = token;
    username = phoneNum ?? '';
    saveData(phoneNum: phoneNum);
  }

  logout() {
    token = "";
    saveData();
    _clearLoginData();
  }

  // 保存数据
  saveData({String? phoneNum}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(token_Key, token);
    if (phoneNum != null) {
      prefs.setString(_username_key, phoneNum);
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
    username = prefs.getString(_username_key) ?? "";
    _privacyAgreeStatus = prefs.getInt(_privacyAgreeStatus_key) ?? -1;
  }
}