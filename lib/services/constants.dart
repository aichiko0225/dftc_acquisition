const dic_prefix_path = 'ssiboot/admin/system/dict/data/type/';

const admin_server_path = 'ssiboot/admin/';

// 通用API
class RequestAPI {
  static const BASEURL = 'https://erp.dfssi.com.cn:28080/';
  // static const BASEURL = 'http://localhost:30011/';
}

// 登录相关
class LoginAPI {
  static String captchaImage = admin_server_path + 'captchaImage';
}
