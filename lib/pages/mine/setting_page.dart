
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/logininfo.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingPageState();
  }
}
class _SettingPageState extends State<SettingPage> {
  var inputText;
  TextEditingController _selectionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            '个人设置',
            style: TextStyle(color: Colors.white),
          ),
      ),
      body: new Container(
        child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            //padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              ListTile(
                onTap: (){
                  _pageToAccountPage();
                },
                leading: const Icon(Icons.account_circle,color: Colors.blue,),
                title: const Text('账户与安全'),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              ListTile(
                leading: const Icon(Icons.favorite,color: Colors.redAccent),
                title: const Text('个人偏好'),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              ListTile(
                leading: const Icon(Icons.supervisor_account,color: Colors.blue),
                title: const Text('切换账号'),
              ),
              new Container(
                height: 20.0,
                color: const Color(0xffebebeb),
              ),
              buildRegisterBtn(context),
              new Container(
                margin: EdgeInsets.only(top: 20),
                height: double.maxFinite,
                color: const Color(0xffebebeb),
              ),
            ]
        )
      ),
    );
  }
  Padding buildRegisterBtn(context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: new RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed:() {
          _pushLogOut();
        },
        child: new Text(
          "退出",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
  void _pushLogOut() {
    if(LoginInfo.isLogin){
      setState(() {
        LoginInfo.id = 0;
        LoginInfo.hasInit=false;
        LoginInfo.userName = "未登录";
        LoginInfo.userCode = "";
        LoginInfo.faceImage ="";
        LoginInfo.userEmail = "";
        LoginInfo.userPhone = "";
        LoginInfo.isLogin=false;
      });
      //先关掉该页面，
      Navigator.of(context).pop();
      //NavigatorRouterUtils.pushToPage(context, MinePage());
    }
  }
  List<DropdownMenuItem> getSexData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('男'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('女'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    return items;
  }
  _pageToAccountPage(){
   // NavigatorRouterUtils.pushToPage(context, AccountPage());
  }
  ///
  /// 保存按钮点击的回调
  ///
  _saveUserInfo() {
    Navigator.pop(context, '$inputText');
  }
  ///
  /// 输入内容改变之后
  ///
  _onInputTextChange(String value) {
    setState(() {
      inputText = value;
    });
  }
}
