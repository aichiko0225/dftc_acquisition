import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 登录验证图片
class LoginCaptchaImage extends StatelessWidget {

  String imageStr;

  LoginCaptchaImage({Key? key, required this.imageStr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageStr.isNotEmpty) {
      Uint8List _airplaneBytes = base64Decode(imageStr);
      return Container(width: 100, height:40 ,child: Image.memory(_airplaneBytes,fit: BoxFit.fill,),);
    }
    return Container(width: 100, height: 40,);
  }
}
