
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RecommendItemWidget extends StatelessWidget{
  final List<Item> items;
  RecommendItemWidget({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width:MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height);
    if(items==null){
      return LoadingWidget();
    }
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(140), // 高度
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: items.length*2,// 数量
        itemBuilder: (BuildContext context, int index) {// 构建
          var i = index;
          i -= 1;
          if (i.isOdd) {
            i = (i + 1) ~/ 2;
            return Column(
              children: <Widget>[
                Container(
                  //flex: 1,
                  height: ScreenUtil().setHeight(120),
                  width: ScreenUtil().setWidth(250),
                  child:GestureDetector(
                    onTap: () async{
                      // this.callback();
                      this.items[i].backColors= await getColorFromUrl(items[i].imgUrl,10);
                      String itemJson = FluroConvertUtils.object2string(this.items[i]);
                      RouterManager.router.navigateTo(
                        context,
                        RouterManager.video2 + "?itemJson=$itemJson",
                        transition: TransitionType.inFromRight,
                      );
                    },
                    child:CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: items[i].imgUrl,
/*                    placeholder: (context, url) => CircularProgressIndicator(
                      value: 0.3,
*//*                        backgroundColor: Color(0xffff0000),
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),*//*
                  ),*/
                      errorWidget: (context, url, error) =>
                          Image.asset('images/img_load_fail.png'),
                    ),
                  )
                ),
                Expanded(
                  child: Text(
                    this.items[i].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ],
            );
          }
          i = i ~/ 2;
          return Container(
            height: ScreenUtil().setHeight(140), // 高度
            width: ScreenUtil().setWidth(5),
            color: Color(0xFFF4F4F4),
          );
/*            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                       *//* 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3932546523,304539533&fm=26&gp=0.jpg'),*//*
                        items[index].imgUrl),
                    fit: BoxFit.fill),
                //borderRadius: BorderRadius.all(Radius.circular(10))
            ),*/

        },
        //onTap: (index) {print('点击了第${index}');},// 点击事件 onTap
      ),
    );
  }
}