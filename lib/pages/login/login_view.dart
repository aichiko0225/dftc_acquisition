import 'package:dftc_acquisition/config/extensions.dart';
import 'package:dftc_acquisition/states/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../components/verify_code_send.dart';
import '../../config/theme_config.dart';
import '../../routes/routes.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());
  final theme = Get.find<ThemeConfig>();

  TextEditingController _loginPhoneNumbController = TextEditingController();
  TextEditingController _loginPhoneCodeController = TextEditingController();

  final FocusNode _focusNodePhoneNumber = FocusNode();
  final FocusNode _focusNodePhoneCode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //设置焦点监听
    _focusNodePhoneNumber.addListener(_focusNodeListener);
    _focusNodePhoneCode.addListener(_focusNodeListener);

    //监听用户名框的输入改变
    _loginPhoneNumbController.addListener(() {
      logic.updatePhoneNum(_loginPhoneNumbController.text);
      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
    });
  }

  // 监听焦点
  Future<void> _focusNodeListener() async {
    if (_focusNodePhoneNumber.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePhoneCode.unfocus();
    }
    if (_focusNodePhoneCode.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodePhoneNumber.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
          style: DFTextStyle.titleStyle,
        ),
      ),
      body: Container(
        color: theme.fillBase,
        child: Column(
          children: [_buildLoginView(), _buildLoginBottonsView()],
        ),
      ),
    );
  }

  Widget _buildLoginView() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 12, right: 12),
      child: Column(
        children: [
          Container(
            child: Text('请输入您的手机号码，登录或注册您的账号'),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: TextField(
              focusNode: _focusNodePhoneNumber,
              controller: _loginPhoneNumbController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 11,
              style: TextStyle(
                fontSize: 16.0,
                color: theme.colorTextBase,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: -6),
                counterText: '',
                border: InputBorder.none,
                icon: const Image(
                  image: AssetImage("./statics/assets/images/icon_phone.png"),
                  width: 20,
                  height: 20,
                ),
                hintText: "请输入手机号",
                hintStyle:
                    TextStyle(fontSize: 16.0, color: theme.colorTextSecondary),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      focusNode: _focusNodePhoneCode,
                      controller: _loginPhoneCodeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 6,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: theme.colorTextBase,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: -6),
                        counterText: '',
                        border: InputBorder.none,
                        icon: const Image(
                          image: AssetImage(
                              "./statics/assets/images/icon_verification.png"),
                          width: 20,
                          height: 20,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          color: theme.colorTextSecondary,
                        ),
                        hintText: "请输入验证码",
                      ),
                    ),
                  ),
                  Obx(() {
                    return VerifyCodeSend(
                        onTapCallback: () {}, available: logic.available.value);
                  }),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBottonsView() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
      height: 46.0,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(theme.brandPrimary),
              textStyle: MaterialStateProperty.all(TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
          onPressed: () async {
            //点击登录按钮，解除焦点，回收键盘
            Application.shared.appState
                .loginSuccess("token", phoneNum: logic.phoneNum);
            Get.offNamed(Routes.root);
          },
          child: Text("登录",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
    );
  }

  @override
  void dispose() {
    Get.delete<LoginLogic>();
    _focusNodePhoneNumber.removeListener(_focusNodeListener);
    _focusNodePhoneCode.removeListener(_focusNodeListener);
    _loginPhoneNumbController.dispose();
    _loginPhoneCodeController.dispose();
    super.dispose();
  }
}
