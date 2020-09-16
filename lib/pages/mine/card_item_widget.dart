
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:fluro/fluro.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CardItemWidget extends StatelessWidget{
  final List<String> widgets;
  CardItemWidget({Key key, this.widgets}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width:MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height);
    if(widgets==null){
      return LoadingWidget();
    }
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(110), // 高度
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: widgets.length,// 数量
        itemBuilder: (BuildContext context, int index) { // 构建
          return _getData(context, index);
        }
      ),
    );
  }
  Widget  _getData(BuildContext context, int position){
    if(widgets!=null){
      return GestureDetector(
        onTap: () {
          print(widgets[position]);
        },
        child:
        Center(
            child: new Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                margin: EdgeInsets.all(5),
                //padding: EdgeInsets.only(top: 2.0),
                child: Center(child: new Text(widgets[position])))),
      );
    }else{
      return null;
    }
  }
}