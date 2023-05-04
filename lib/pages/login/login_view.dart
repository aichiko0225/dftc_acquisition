import 'package:bruno/bruno.dart';
import 'package:dftc_acquisition/config/extensions.dart';
import 'package:dftc_acquisition/generated/assets.dart';
import 'package:dftc_acquisition/states/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../config/theme_config.dart';
import '../../routes/routes.dart';
import 'login_checkout.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());
  final theme = Get.find<ThemeConfig>();

  //焦点
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    //监听用户名框的输入改变
    _userNameController.addListener(() {
      logic.updatePhoneNum(_userNameController.text);
    });
    _pwdController.addListener(() {
      logic.updatePassword(_pwdController.text);
    });

    initData();
  }

  initData() async {
    var userName = Application.shared.appState.userName;
    var password = Application.shared.appState.password;
    var rememberPassword = Application.shared.appState.rememberPassword;
    if (userName.isNotEmpty) {
      _userNameController.text = userName;
    }
    if (password.isNotEmpty) {
      _pwdController.text = password;
    }
    logic.rememberPwd.value = rememberPassword;
  }

  // 监听焦点
  Future<void> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  void _onLoginButtonTap() async {
    //点击登录按钮，解除焦点，回收键盘
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();
    // 默认存用户名，如果选择记住密码，则用户名和密码都会存储
    if (logic.rememberPwd.value) {
      Application.shared.appState
          .loginSuccess("token", userName: logic.userName, password: logic.password);
    } else {
      Application.shared.appState
          .loginSuccess("token", userName: logic.userName);
    }

    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 1000), () {
      EasyLoading.dismiss();
      Get.offNamed(Routes.root);
    });
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
      body: GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: Container(
          color: theme.fillBase,
          child: Column(
            children: [_buildLoginView(), _buildLoginBottonsView()],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginView() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 12, right: 12),
      child: Column(
        children: [
          _inputTextArea(),
        ],
      ),
    );
  }

  //输入文本框区域
  Widget _inputTextArea() {
    return SizedBox(
      height: 206.0,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            height: 50,
            child: TextField(
              focusNode: _focusNodeUserName,
              controller: _userNameController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 14.0,
                color: theme.colorTextBase,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: -6),
                border: InputBorder.none,
                icon: Image(
                  image: AssetImage(Assets.imagesIconPhone),
                  width: 20,
                  height: 20,
                ),
                hintText: "请输入用户名/手机号",
                hintStyle:
                    TextStyle(fontSize: 14.0, color: theme.colorTextSecondary),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: 0.75,
            color: Color(0xFFD8D8D8),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Obx(() {
                      return TextField(
                        focusNode: _focusNodePassWord,
                        controller: _pwdController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: theme.colorTextBase,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: -6),
                          icon: const Image(
                            image: AssetImage(Assets.imagesIconLocker),
                            width: 20,
                            height: 20,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: theme.colorTextSecondary,
                          ),
                          hintText: "请输入您的密码",
                        ),
                        obscureText: !logic.showPwd.value,
                      );
                    }),
                  ),
                  Obx(() {
                    return IconButton(
                      icon: Icon((logic.showPwd.value)
                          ? Icons.visibility
                          : Icons.visibility_off),
                      // 点击改变显示或隐藏密码
                      onPressed: () {
                        logic.updateShowPassword(!logic.showPwd.value);
                      },
                    );
                  }),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: 0.75,
            color: Color(0xFFD8D8D8),
          ),
          _bottomArea(),
        ],
      ),
    );
  }

  //忘记密码  立即注册
  Widget _bottomArea() {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Obx(() {
            return LoginCheckbox(
              iconPadding:
                  EdgeInsets.only(right: 12, left: 5, top: 5, bottom: 5),
              isSelected: logic.rememberPwd.value,
              onValueChangedAtIndex: (selected) async {
                logic.rememberPwd.value = selected;
                Application.shared.setRememberPassword(selected);
              },
              child: Text("记住密码",
                  style: TextStyle(
                    color: theme.colorTextBase,
                    fontSize: 14.0,
                  )),
            );
          }),
          TextButton(
            onPressed: () {
              BrnToast.showInCenter(text: "立即注册", context: context);
            },
            child: Text('立即注册',
                style: TextStyle(
                  color: theme.colorTextBase,
                  fontSize: 14.0,
                )),
          )
        ],
      ),
    );
  }

  Widget _buildLoginBottonsView() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
      height: 46.0,
      child: Obx(() {
        return TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return theme.brandPrimary?.withAlpha(88);
                  }
                  return theme.brandPrimary;
                }),
                textStyle: MaterialStateProperty.all(TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold))),
            onPressed: logic.available.value ? _onLoginButtonTap : null,
            child: Text("登录",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)));
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<LoginLogic>();
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }
}
