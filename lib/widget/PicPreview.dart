import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movie_app/util/urlUtl.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:movie_app/data/entity/loginInfo.dart';
import 'package:movie_app/data/entity/userInfo.dart';
import 'package:movie_app/util/ImageUtil.dart';
import 'package:movie_app/util/fade_in_cache.dart' as fcache;
import 'messageAlter.dart';

class PicPreview extends StatefulWidget {
  PicPreview({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyBoxPageState createState() => _MyBoxPageState();
}

class _MyBoxPageState extends State<PicPreview> {
  List widgets = [];
  FileImage _fileImage;
  double width;
  double height;
  bool setFace = false;
  //裁剪后的的头像文件
  File cropFile;
  String imgPath;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      imgPath = Url.ImageUrl + LoginInfo.faceImageBig;
    });
    //loadData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      child: getListView(),
    );
  }

  getListView() {
    return GestureDetector(
      onLongPress: () {
        _myImagePer();
      },
      child: new Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return getChild(index);
          },
          itemCount: 1,
        ),
        // color: Colors.white,
      ),
    );
  }

  getChild(int position) {
    print("child ${position}");
    // var d = widgets[position];
    return Container(
      child: fcache.FadeInImage.memoryNetwork(
        image: imgPath,
        sdcache: true,
        placeholder: kTransparentImage,
        width: width,
        height: height,
        // height: d["height"]* width/d["width"],
      ),
    );
//    Image.network(src)
  }

  void _myImagePer() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            //color: Style.iconColor,
            child:new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.crop_original),
                    title: new Text("保存图片"),
                    onTap: () {
                      Navigator.pop(context);
                      _saveImageLocal();
                      //   Image.network(src)
                      //   MyNetworkImage.saveToImage(mUint8List, name);
                    }),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                 // color: Style.cardColor,
                ),
                new ListTile(
                  leading: new Icon(Icons.crop),
                  title: new Text("裁剪图片"),
                  onTap: () async {
                    Navigator.pop(context);
                    _cropImage();
                  },
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                  //color: Style.cardColor,
                ),
                new ListTile(
                  enabled: setFace,
                  leading: new Icon(Icons.cancel),
                  title: new Text("撤销"),
                  onTap: () async {
                    setState(() {
                      imgPath = Url.ImageUrl + LoginInfo.faceImageBig;
                    });
                    Navigator.pop(context);
                  },
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                 // color: Style.cardColor,
                ),
                new ListTile(
                  enabled: setFace,
                  leading: new Icon(Icons.face),
                  title: new Text("设为头像"),
                  onTap: () async {
                    if (setFace) {
                      Navigator.pop(context);
                      _setToFaceImage();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  _saveImageLocal() async {
    await ImageUtil.saveImage(imgPath, imgPath);
    Alter.show(context, "保存成功");
  }

  _cropImage() async {
    //从手机中获取图片路径
    String imagePth = await ImageUtil.getImagePathFromSd(imgPath);
    var file = File(imagePth);
    bool exist = await file.exists();
    if (!exist) {
      imagePth = await ImageUtil.saveImage(imgPath, imgPath);
    }
    File image = await ImageUtil.cropImage(imagePth);
    if (image != null) {
      setState(() {
        cropFile = image;
        setFace = true;
        imgPath = image.path;
      });
    }
  }

  _setToFaceImage() async {
    //请求后台保存图片信息
    //先将图片转换为base64字符串
    List<int> byteData = await cropFile.readAsBytes();
    String bs64 = base64Encode(byteData);
    LoginInfo.faceImage = bs64;
    UserInfo userInfo = new UserInfo.empty();
    userInfo.id = LoginInfo.id;
    userInfo.faceImage = LoginInfo.faceImage;
    // json.
   // HttpUtils.post(Api.SET_FACE_IMAGE, success, context,params: json.decode(json.encode(userInfo)), errorCallBack: fail);
  }

  success(RspObj data) {
    UserInfo user = UserInfo.fromJson(data.data);
    setState(() {
      LoginInfo.faceImage = user.faceImage;
      LoginInfo.faceImageBig = user.faceImageBig;
      Navigator.pop(context);
    });
  }

  fail(RspObj data) {
    Alter.show(context, data.message);
  }
}
