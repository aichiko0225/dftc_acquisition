import 'dart:async';
import 'package:flutter/material.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
const TextStyle _availableStyle = TextStyle(
  fontSize: 12.0,
  color: Color(0xFF1D7FF2),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
const TextStyle _unavailableStyle = TextStyle(
  fontSize: 12.0,
  color: Color(0xFF65728C),
);

class VerifyCodeSend extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;
  final Color borderColor;

  /// 用户点击时的回调函数。
  final Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  final bool available;
  bool isAutoCountdown = false;
  VerifyCodeSend({
    Key? key,
    this.countdown: 60,
    required this.onTapCallback,
    this.available = false,
    this.borderColor = const Color(0xFF999999),
    this.isAutoCountdown = false,
  }) : super(key: key);

  @override
  _VerifyCodeSendState createState() => _VerifyCodeSendState();
}

class _VerifyCodeSendState extends State<VerifyCodeSend> {
  /// 倒计时的计时器。
  Timer? _timer;

  /// 当前倒计时的秒数。
  int _seconds = 0;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
    if (widget.isAutoCountdown) {
      _countDown();
    }
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '${_seconds}s 重发';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '获取验证码';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // 墨水瓶（`InkWell`）组件，响应触摸的矩形区域。
    return widget.available
        ? InkWell(
      child: Container(
        width: 74,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.elliptical(4, 4),
              bottom: Radius.elliptical(4, 4),
            )),
        child: Text(
          '  $_verifyStr  ',
          style: inkWellStyle,
        ),
      ),
      onTap: (_seconds == widget.countdown) ? _countDown : null,
    )
        : InkWell(
      child: Container(
        width: 74,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.elliptical(4, 4),
              bottom: Radius.elliptical(4, 4),
            )),
        child: const Text(
          '获取验证码',
          style: _unavailableStyle,
        ),
      ),
    );
  }

  _countDown() {
    _startTimer();
    inkWellStyle = _unavailableStyle;
    _verifyStr = '${_seconds}s 重发';
    setState(() {});
    widget.onTapCallback();
  }
}
