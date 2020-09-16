import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/widget/follow_title_widget.dart';
import 'package:movie_app/util/urlUtl.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/LoginInfo.dart';
import 'package:movie_app/data/entity/userInfo.dart';
import 'package:movie_app/pages/mine/setting_page.dart';
import 'package:movie_app/util/ImageUtil.dart';
import 'package:movie_app/widget/PicPreview.dart';
import 'package:movie_app/widget/listTitleCard.dart';
import 'package:movie_app/widget/messageAlter.dart';
import 'package:movie_app/widget/separator.dart';

import 'card_item_widget.dart';
import 'login_page.dart';
import 'userInfoEdit_page.dart';

class MinePage extends StatefulWidget{
  @override
  State createState() {
    return new _MinePageState();
  }
}
class _MinePageState extends State<MinePage> {
  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  List<String> widgets = new List<String>.generate(10, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints:  BoxConstraints.expand(),
        color:  Color(0xFF736AB7),
        child: Stack (
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
          //  _getToolbar(context),
          ],
        ),
      ),
    );
  }
  Container _getBackground () {
    return new Container(
      child: new Image.asset("assets/images/backGround.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
    constraints: new BoxConstraints.expand(height: 300.0),
    );
  }
  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00736AB7),
            new Color(0xFF736AB7)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 32.0),
        children: <Widget>[
          new Container(
/*            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),*/
            child: new Stack(
              children: <Widget>[
                _builderCard(),
                _builderFaceImg(),
              ],
            ),
          ),
          new Container(
/*            margin: const EdgeInsets.symmetric(
              //vertical: 10.0,
              horizontal: 10.0,
            ),*/
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Separator(),
                _buildNumPanel(),
                _buildListPanel("观看历史",this.widgets),
                new Separator(),
                _buildListPanel("愿望单",this.widgets),
/*                ListTitleCard("观看历史",widgets,90,60,Colors.white,null),
                ListTitleCard("我的愿望单",widgets,MediaQuery.of(context).size.width-60,60),*/
                new Separator(),
                _buildMyFunPanel(),
                new Separator(),
                _buildHelpAndCallPanel(),
                new Separator(),
                _buildSettingPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  static Widget _planetValue({String value, String image}) {
    return new Container(
      child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(value,),
          ]
      ),
    );
  }
  Container _builderCardContent(){
    return new Container(
      margin: new EdgeInsets.fromLTRB( 0.0,42.0, 0.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new GestureDetector(
            onTap: () {
              _showUserInfo();
            },
            child: new Text(LoginInfo.userName.isNotEmpty?LoginInfo.userName:"点击登录",),
          ),
          new Container(child: new Center(), height: 10.0),
          new Text(LoginInfo.userCode,),
          new Container(child: new Center(), height: 3.0),
          new Separator(),
          new Container(child: new Center(), height: 3.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex:  0,
                  child: _planetValue(
                      value: "54.6m Km",
                      image: 'assets/images/ic_distance.png')
              ),
              new Container (
                width: 32.0,
              ),
              new Expanded(
                  flex:  0,
                  child: _planetValue(
                      value: "4.711 m/s",
                      image: 'assets/images/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );
  }
  Container _builderFaceImg(){
   return new Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment:  FractionalOffset.center,
      child:new GestureDetector(
        onTap: () {
          _pushLogin();
        },
       child: new Hero(
         tag: "planet-hero-${LoginInfo.id}",
         child: ClipOval(
           clipBehavior: Clip.hardEdge,
           child:
           LoginInfo.faceImage.isNotEmpty ? Image.network(Url.ImageUrl+LoginInfo.faceImage,width: 92,height: 92,fit: BoxFit.cover,) : Image.asset("images/avatar.png", width: 92,height: 92,fit: BoxFit.cover),
         ),
        ),
      )
    );
  }
  Container _builderCard(){
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
           // color: Colors.greenAccent,
            child: new Image.asset("assets/images/VipLeve.png",width: 30,height: 30,),
            width: (MediaQuery.of(context).size.width-80)/8,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(50.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
          ),
          new Container(
           // color: Colors.deepOrange,
            child:_builderCardContent(),
            width: (MediaQuery.of(context).size.width)-150,
          ),
          new Container(
            child: new Image.asset("images/Sign-icon.png",width: 30,height: 30,),
            width: (MediaQuery.of(context).size.width-80)/8,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(50.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
          )
        ],
      ),
      height:  154.0,
      margin: new EdgeInsets.only(top: 72.0,left: 5,right: 5),
      decoration: new BoxDecoration(
       // color: Colors.blue,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(30.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }
  Card _buildNumPanel(){
   return new Card(
/*     margin: new EdgeInsets.symmetric(
        // vertical: 16.0
       horizontal: 25
     ),*/
      //color:  Style.cardColor,
     // height:60.0,
     // padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              _showFansPage();
            },
            child:buildButtonColumn("粉丝", '1',),
          ),
          new GestureDetector(
            onTap: () {
              _showConcernPage();
            },
            child:buildButtonColumn("关注", '2',),
          ),
          new GestureDetector(
            onTap: () {
              _showPublishPage();
            },
            child:buildButtonColumn("发布", '2',),
          ),
          new GestureDetector(
            onTap: () {
              _showWishPage();
            },
            child:buildButtonColumn("消息", '3',),
          ),
        ],
      ),
    );
  }
  Column buildButtonColumn(String title, String label) {
    //Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // new Icon(icon, color: color),
        new Text(
          label,
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            //color: color,
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(title,
            //style: Style.commonTextStyle
          ),
        ),
      ],
    );
  }
  Card _buildMyFunPanel() {
    return Card(
      child:
      new Column(
        children: <Widget>[
          FollowTitleWidget(title:"我的功能",callback: null,more:false),
          new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(4,0,0,5),
                child: new SizedBox(
                  child:new Card(
                    // color: Style.iconColor,
                    child: new Center(
                      child:  new Text('支付', style: new TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
                  ),
                  height: 60,
                  width: 80,
                ),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(4,0,0,5),
                child: new SizedBox(
                  child:new Card(
                    //color: Style.iconColor,
                    child: new Center(
                      child:  new Text('举报', style: new TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
                  ),
                  height: 60,
                  width: 80,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Card _buildListPanel(String title,List widgets){
    return new Card(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FollowTitleWidget(title:title,callback: null,more:false),
          CardItemWidget(widgets:widgets),
        ],
      )
    );
  }
  Container _buildHelpAndCallPanel() {
    return new Container(
      //color: Style.cardColor,
      child: ListTile(
        leading: const Icon(Icons.help,color: Color(0xFF736AB7)),
        title: const Text('反馈与帮助',style: TextStyle(
            color: const Color(0xffb6b2df),
            fontSize: 14.0,
            fontWeight: FontWeight.w400
        ),),
      ),
    );
  }
  Container _buildSettingPanel() {
    return new Container(
     // color: Style.cardColor,
      child:ListTile(
        leading: const Icon(Icons.settings,color: Color(0xFF736AB7)),
        title: const Text('设置',style: TextStyle(
            color: const Color(0xffb6b2df),
            fontSize: 14.0,
            fontWeight: FontWeight.w400
        ),),
        onTap: (){
          _showUserSetting();
        },
      ),
    );
  }
  void _showUserSetting() {
    if(LoginInfo.isLogin){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return SettingPage();
            },
          )
      );
    }else{
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return LoginPage();
            },
          )
      );
    }
  }
  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top),
      child: new BackButton(color: Colors.white),
    );
  }
  void _showFansPage(){
    print("粉丝数");
  }
  void _showConcernPage(){
    print("关注数");
  }
  void _showPublishPage(){
    print("发布数");
  }
  void _showWishPage(){
    print("愿望单");
  }
  void _showImageView(){
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            return  PicPreview();
          },
        )
    );
  }
  void _pushLogin() {
    if(LoginInfo.isLogin){
      _modalBottomSheetMenu();
    }else{
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return LoginPage();
            },
          )
      );
    }
  }
  void _showUserInfo() {
    if(LoginInfo.isLogin){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return EditUserInfoPage();
            },
          )
      );
    }else{
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return LoginPage();
            },
          )
      );
    }
  }
  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return new Container(
          //  color: Style.iconColor,
            child:new Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               new Container(
                 padding:const EdgeInsets.only(top: 10.0,bottom: 10.0),
                 child: new Text("头像信息",
                   style:new TextStyle(
                       color: const Color(0xff353535), fontSize: 20.0,fontWeight: FontWeight.bold),
                 ),
               ),
               new Container(
                 margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                 height: 1.0,
                 //color: Style.cardColor,
               ),
               new ListTile(
                 leading: new Icon(Icons.crop_original),
                 title: new Text("查看图片"),
                 onTap: () {
                   Navigator.pop(context);
                   _showImageView();
                 },
               ),
               new Container(
                 margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                 height: 1.0,
                 //color: Style.cardColor,
               ),
               new ListTile(
                 leading: new Icon(Icons.photo_camera),
                 title: new Text("拍照"),
                 onTap: () async {
                   Navigator.pop(context);
                  new  ImageUtil().pickerImage().then((imageFile){
                     _cropImage(imageFile);
                   });
                 },
               ),
               new Container(
                 margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                 height: 1.0,
               //  color: Style.cardColor,
               ),
               new ListTile(
                 leading: new Icon(Icons.photo_library),
                 title: new Text("从相册中获取",),
                 onTap: () async {
                   Navigator.pop(context);
                  new  ImageUtil().getImageFromMyGallery().then((imageFile){
                     _cropImage(imageFile);
                   });
                 },
               ),
             ],
           ),
          );
        }
    );
  }
  Future _cropImage(File imageFile) async {
    var image = await ImageUtil.cropImage(imageFile.path);
    if (image != null) {
      //请求后台保存图片信息
      //先将图片转换为base64字符串
      List<int> byteData = await image.readAsBytes();
      String bs64 = base64Encode(byteData);
      LoginInfo.faceImage = bs64;
      UserInfo userInfo = new UserInfo.empty();
      userInfo.id=LoginInfo.id;
      userInfo.faceImage=LoginInfo.faceImage;
      // json.
     // HttpUtils.post(Api.SET_FACE_IMAGE,success,context,params: json.decode(json.encode(userInfo)),errorCallBack: fail);
    }
  }
  success(RspObj data) {
    UserInfo user = UserInfo.fromJson(data.data);
    setState(() {
      LoginInfo.faceImage = user.faceImage;
      LoginInfo.faceImageBig = user.faceImageBig;
    });
  }
  fail(RspObj data) {
    Alter.show(context, data.message);
  }
}