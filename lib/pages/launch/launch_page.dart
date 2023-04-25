import 'package:dftc_acquisition/states/application.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme_config.dart';
import '../../routes/routes.dart';
import 'launch_logic.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  final logic = Get.put(LaunchLogic());
  final themeData = Get.find<ThemeConfig>();

  var privacyAgree = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    privacyAgree = Application.shared.appState.privacyAgreeStatus == 1;

    if (privacyAgree) {
      var isLogin = Application.shared.appState.isLogin();
      if (isLogin) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.offNamed(Routes.root);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.offNamed(Routes.login);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!privacyAgree) {
      return _privacyAgreePage();
    }
    return Container();
  }

  Widget _privacyAgreePage() {
    return WillPopScope(
      onWillPop: () async {
        // 禁用返回键
        return false;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 35),
          color: Color(0x35000000),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 2.0),
                      blurRadius: 10.0)
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 28, bottom: 18),
                  child: Text(
                    '温馨提示',
                    // style: DFTextStyle.launch_titleStyle,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 180),
                  child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                      child: Text.rich(_buildRichTextSpans())),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 28.0, left: 28, right: 28, top: 20),
                  child: _buildButtonsView(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _buildRichTextSpans() {
    /* 1.为了启动应用后信息推送，我们会获取设备IMEI、MAC地址。\n
    2.为了使用该手机号进行登录时方便验证码输入，我们会获取短信\n
    3.为了给您提供附近站点区域、召车等服务，我们会申请使用你的位置信息。\n
    4.为了提高试乘安全，在您添加紧急联系人时，我们会获取您的通讯录以便快速添加信息\n
    5.为了在召车、试乘过程中可以快速联系客服、安全员、紧急联系人，我们会获取您的电话权限\n
    6.为了在试乘接驾后确认您所约车辆与上车车辆一致，我们会获取您的相机权限用于扫码车内二维码\n
    7.为了获取东风领航App最新版本，我们在下载更新时会获取您的存储权限'''
    */
    var normal_textStyle =
        TextStyle(fontSize: 14, color: Color(0xFF6D7278), height: 1.5);
    var main_textStyle = TextStyle(
        decoration: TextDecoration.underline,
        color: themeData.brandPrimary,
        fontSize: 14,
        height: 1.5);

    return TextSpan(children: [
      TextSpan(
          text: '    欢迎使用远程数采系统App！在使用远程数采系统App服务前，请您充分阅读并理解',
          style: normal_textStyle),
      TextSpan(
          text: '《用户协议》',
          recognizer: TapGestureRecognizer()..onTap = logic.userAgreementOnTap,
          style: main_textStyle),
      TextSpan(text: '及', style: normal_textStyle),
      TextSpan(
          text: '《隐私政策》',
          recognizer: TapGestureRecognizer()..onTap = logic.privacyPolicyOnTap,
          style: main_textStyle),
      TextSpan(text: '全部条款、你同意并接受全部条款后再开始使用我们的服务。\n', style: normal_textStyle),
      TextSpan(
          text:
              '    您可以使用远程数采系统App查看车辆位置，实时监测等服务。我们可能会用到您的位置信息、设备信息等信息，您可以在设备系统"设置"里进行相关权限信息管理。\n',
          style: normal_textStyle),
    ]);
  }

  Widget _buildButtonsView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 40.0,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFFF46F58),
                    Color(0xFFE64242),
                  ],
                  stops: const [0, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: TextButton(
              onPressed: logic.notAgreeOnPressed,
              child: Text(
                '不同意',
                style: TextStyle(fontSize: 18, color: Color(0xFF352E2C)),
              ),
              style: ButtonStyle(
                // 文字颜色
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return themeData.colorTextDisabled;
                    }
                    return Colors.white;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return themeData.fillBody;
                  },
                ),
                // 水波纹
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  return (themeData.fillBody)?.withOpacity(0.12);
                }),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )),
        Container(
            height: 40.0,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: const [
                    Color(0xFFF46F58),
                    Color(0xFFE64242),
                  ],
                  stops: const [0, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: TextButton(
              onPressed: logic.agreeOnPressed,
              child: Text(
                '同意并继续',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ButtonStyle(
                // 文字颜色
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return themeData.colorTextDisabled;
                    }
                    return Colors.white;
                  },
                ),
                // 水波纹
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  return (themeData.brandPrimaryTap)?.withOpacity(0.12);
                }),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
