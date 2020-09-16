
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LastItemWidget extends StatelessWidget{
  final List<Item> items;
  LastItemWidget({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width:MediaQuery.of(context).size.width,height:MediaQuery.of(context).size.height);
    if(items==null){
      return LoadingWidget();
    }
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(160), // 高度
      child: Swiper(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: items.length,// 数量
        autoplay: true,// 自动翻页
        loop: true, // 无线轮播
        itemBuilder: (BuildContext context, int index) {// 构建
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                //flex: 1,
                height: ScreenUtil().setHeight(140),
                width: ScreenUtil().setWidth(250),
                child:CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: items[index].imgUrl,
/*                    placeholder: (context, url) => CircularProgressIndicator(
                        value: 0.3,
*//*                        backgroundColor: Color(0xffff0000),
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),*//*
                    ),*/
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail.png'),
                ),
              ),
              Expanded(
                child: Text(
                  this.items[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: Color(0xFF333333),
                  ),
                ),
              ),

/*              Container(
                //margin: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                 // height: 15,
                  child: Text(
                    this.items[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ),*/
            ],
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
        onTap: (index) async{
          this.items[index].backColors= await getColorFromUrl(items[index].imgUrl,10);
          String itemJson = FluroConvertUtils.object2string(this.items[index]);
          RouterManager.router.navigateTo(
            context,
            RouterManager.video2 + "?itemJson=$itemJson",
            transition: TransitionType.inFromRight,
          );
        },// 点击事件 onTap
/*        pagination: SwiperPagination( // 分页指示器
            alignment: Alignment.bottomCenter,// 位置 Alignment.bottomCenter 底部中间
            margin: const EdgeInsets.only(top:150), // 距离调整
            builder: DotSwiperPaginationBuilder(
              activeColor: Colors.black,
              color: Colors.grey,
              size: ScreenUtil().setWidth(5),
              activeSize: ScreenUtil().setWidth(10),
              space: ScreenUtil().setWidth(10),
            )),*/
        viewportFraction: 0.6,// 当前视窗展示比例 小于1可见上一个和下一个视窗
        //layout: SwiperLayout.TINDER,
        scale: 0.95, // 两张图片之间的间隔
      ),
    );
  }
}