import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/userInfo.dart';
import 'package:movie_app/util/str_util.dart';
import 'package:movie_app/widget/share_data_widget.dart';
import 'package:movie_app/widget/messageAlter.dart';
import 'package:movie_app/widget/verifyCodeBtn.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage(this.sPhoneNum);
  String sPhoneNum;
  @override
  Widget build(BuildContext context) {
    return new _CreatePage(this.sPhoneNum);
  }
}
class _CreatePage extends StatefulWidget {
  _CreatePage(this.sPhoneNum);
  final String sPhoneNum;
  @override
  createState() => new _CreateRegisterPage(this.sPhoneNum);
  //这里提供了一个static方法，是为了外面好获取
}
class _CreateRegisterPage extends State<_CreatePage> {
  _CreateRegisterPage(this._phoneNum);
  TextEditingController _selectionController = new TextEditingController();
  static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;
  String _phoneNum="";
  String _verifyCode="";
  String _errorPhone="";
  String _errorVerCode="";
  @override
  void initState() {
    super.initState();
    _selectionController.text=_phoneNum;
  }
  @override
  Widget build(BuildContext context) {
    return new ShareDataWidget(
      data: _phoneNum,
      child: new Scaffold(
        key:_globalKey ,
        body: Form(
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0),
                buildPhoneTextField(context),
                //SizedBox(height: 30.0),
                buildVerifyCodeTextField(context),
                //buildPhoneTextField(context),
                buildRegisterBtn(context),
              ]
          )
        )
      ),
    );
  }
  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '用户注册',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
  Widget buildPhoneTextField(BuildContext context) {
    var node = new FocusNode();
    return new Padding(
     padding: const EdgeInsets.only(top: 20),
      child: new TextField(
        //autofocus: true,
        focusNode: focusNode1,//关联focusNode1
        controller: _selectionController,
        onChanged: (str) {
          setState(() {
            if(_errorPhone.isNotEmpty){
              _errorPhone="";
            }
            _phoneNum = str;
          });
        },
        decoration: new InputDecoration(
          icon: Icon(Icons.phone),
          hintText: '请输入手机号',
          errorText: '$_errorPhone'.isEmpty?null:'$_errorPhone',
        ),
      //  controller: TextEditingController(text: '$_phoneNum'),
        maxLines: 1,
        maxLength: 11,
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (text) {
          FocusScope.of(context).requestFocus(node);
        },
      ),
    );

  }
  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }
  Widget buildVerifyCodeTextField(BuildContext context) {
    var node = new FocusNode();
    Widget verifyCodeEdit = new TextField(
      focusNode: focusNode2,//关联focusNode2
      onChanged: (str) {
        setState(() {
          if(_errorVerCode.isNotEmpty){
            _errorVerCode="";
          }
          _verifyCode = str;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.confirmation_number),
        hintText: '请输入短信验证码',
        errorText: '$_errorVerCode'.isEmpty?null:'$_errorVerCode',
      ),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).requestFocus(node);
      },
    );

    return new Padding(
      padding: const EdgeInsets.only( top: 10.0),
      child: new Stack(
        children: <Widget>[
          verifyCodeEdit,
          new Align(
            alignment: Alignment.bottomRight,
            child: new CreateVerifyCodeBtn(),
          ),
        ],
      ),
    );
  }
  Padding buildRegisterBtn(context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed:(_phoneNum.isEmpty || _verifyCode.isEmpty) ? null : () {
          register();
        },
        child: new Text(
          "注册",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
  void register(){
    FocusScope.of(context).requestFocus(FocusNode());
    if(null == focusScopeNode){
      focusScopeNode = FocusScope.of(context);
    }
    if (!StringUtil.isPhoneNum(_phoneNum)) {
      _errorPhone ="请输入正确的手机号";
      focusScopeNode.requestFocus(focusNode1);
      return;
    }else{
      _errorPhone="";
    }
    if(_verifyCode.isEmpty){
      _errorVerCode ="请输入验证码";
      focusScopeNode.requestFocus(focusNode2);
      return;
    }else{
      _errorVerCode="";
      _errorVerCode="";
    }
    UserInfo userInfo = new UserInfo.empty();
    userInfo.userPhone=_phoneNum;
    userInfo.userPwd='11111';
    print('phoneNum:$_phoneNum');
   // HttpUtils.post(Api.REGISTER,ssucce,context,params: userInfo.toJson(),errorCallBack: fail);
  }
  void ssucce(RspObj data){
    Alter.show(_globalKey.currentContext,"注册成功");
    Navigator.of(context).pop();
  }
  void fail(RspObj data){
    Alter.show(_globalKey.currentContext, data.message);
  }
}

