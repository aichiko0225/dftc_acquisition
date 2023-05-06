import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../config/extensions.dart';
import '../../config/theme_config.dart';
import '../../generated/assets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final themeConfig = Get.find<ThemeConfig>();

  //焦点
  final FocusNode _focusNodeUserName = FocusNode();
  final FocusNode _focusNodeNickname = FocusNode();
  final FocusNode _focusNodePassWord = FocusNode();
  final FocusNode _focusConfirmPwd = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  // button可用
  var available = false;

  var userName = '';
  var nickname = '';
  var password = '';
  var confirmPwd = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听用户名框的输入改变
    _userNameController.addListener(() {
      userName = _userNameController.text;
      _buttonAvailable();
    });
    _pwdController.addListener(() {
      password = _pwdController.text;
      _buttonAvailable();
    });
    _confirmPwdController.addListener(() {
      confirmPwd = _confirmPwdController.text;
      _buttonAvailable();
    });
  }

  _buttonAvailable() {
    var aaa = userName.isNotEmpty && password.isNotEmpty && confirmPwd.isNotEmpty;
    if (available != aaa ){
      setState(() {
        available = aaa;
      });
    }
  }

  _onRegisterButtonTap() {
    _focusNodePassWord.unfocus();
    _focusNodeUserName.unfocus();
    _focusConfirmPwd.unfocus();

    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 1000), () {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('注册成功');
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '注册',
          style: DFTextStyle.titleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
          _focusConfirmPwd.unfocus();
        },
        child: Container(
          color: themeConfig.fillBase,
          padding: EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            children: [_inputTextArea(), _buildRegisterBottonsView()],
          ),
        ),
      ),
    );
  }

  //输入文本框区域
  Widget _inputTextArea() {
    return Container(
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
                color: themeConfig.colorTextBase,
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
                hintStyle: TextStyle(
                    fontSize: 14.0, color: themeConfig.colorTextSecondary),
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
                    child: TextField(
                      focusNode: _focusNodePassWord,
                      controller: _pwdController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: themeConfig.colorTextBase,
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
                          color: themeConfig.colorTextSecondary,
                        ),
                        hintText: "请输入您的密码",
                      ),
                      obscureText: true,
                    ),
                  ),
                ]),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    // maxLength: 6,
                    focusNode: _focusConfirmPwd,
                    controller: _confirmPwdController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: themeConfig.colorTextBase,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: -6),
                      icon: const Image(
                        image: AssetImage(Assets.imagesIconVerification),
                        width: 20,
                        height: 20,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: themeConfig.colorTextSecondary,
                      ),
                      hintText: "请再次输入密码",
                      counterText: '',
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            height: 0.75,
            color: Color(0xFFD8D8D8),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterBottonsView() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
      height: 46.0,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return themeConfig.brandPrimary?.withAlpha(88);
                }
                return themeConfig.brandPrimary;
              }),
              textStyle: MaterialStateProperty.all(TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
          onPressed: available ? _onRegisterButtonTap : null,
          child: Text("注册",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _pwdController.dispose();
    _confirmPwdController.dispose();
    super.dispose();
  }
}
