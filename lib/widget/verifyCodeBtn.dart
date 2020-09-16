import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/smsCodeDto.dart';
import 'package:movie_app/util/str_util.dart';
import 'package:movie_app/widget/share_data_widget.dart';
import 'messageAlter.dart';

class CreateVerifyCodeBtn extends StatefulWidget {
  @override
  State<CreateVerifyCodeBtn> createState() => CreateBtn();
}

class CreateBtn extends State<CreateVerifyCodeBtn> {
  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  int _seconds = 0;
  String _verifyStr = "获取验证码";
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    //ShareDataWidget shareDataWidget = ShareDataWidget.of(context);
    final myWidget = ShareDataWidget.of(context);
    return new InkWell(
      key: _globalKey,
      onTap: (_seconds == 0)
          ? () {
              setState(() {
                String sPhoneNum = myWidget.data;
                if (StringUtil.isPhoneNum(sPhoneNum)) {
                  SmsCodeDto smsCode = new SmsCodeDto('$sPhoneNum', '00');
                  print('phoneNum:$sPhoneNum');
                 // HttpUtils.post(Api.SEND_SMS_CODE, ssucce, context, params: smsCode.toJson(), errorCallBack: fail2);
                } else {
                  Alter.show(context, "请输入正确的手机号");
                  return;
                }
              });
            }
          : null,
      child: new Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 36.0,
        decoration: new BoxDecoration(
          border: new Border.all(
            width: 1.0,
            color: Colors.blue,
          ),
        ),
        child: new Text(
          '$_verifyStr',
          style: new TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }

  _startTimer() {
    _seconds = 10;
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  void ssucce(RspObj data) {
    Alter.show(_globalKey.currentContext, "短信已发送");
    _startTimer();
  }

  void fail2(RspObj data) {
    Alter.show(_globalKey.currentContext, data.message);
  }
}
