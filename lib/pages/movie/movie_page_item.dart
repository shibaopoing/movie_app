import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/urlUtl.dart';
class MoviePageItem extends StatelessWidget {
  final double itemHeight =120;
  final MovieInfo item;
  MoviePageItem({Key key, this.item}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  @override
  Widget build(BuildContext context) {
    double coverSize = 110;
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              key: _globalKey,
              fit: StackFit.passthrough,
              children: <Widget>[
                //显示影片预览图
                GestureDetector(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: item.imgUrl,
/*                    placeholder: (context, url) => CircularProgressIndicator(
                        value: 0.3,
*//*                        backgroundColor: Color(0xffff0000),
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),*//*
                    ),*/
                    errorWidget: (context, url, error) =>
                        Image.asset('images/img_load_fail.png'),
                  ),
                  onTap: () async {
                    this.item.backColors= await getColorFromUrl(item.imgUrl,10);
                    String itemJson = FluroConvertUtils.object2string(this.item);
                    RouterManager.router.navigateTo(
                      context,
                      RouterManager.video2 + "?itemJson=$itemJson",
                      transition: TransitionType.inFromRight,
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: coverSize / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromARGB(100, 0, 0, 0)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          Helper.numFormat(this.item.playsCount),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          this.item.score,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                !this.item.needVip ? null : Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 2, 10, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                          colors: [Color(0xFFA17551), Color(0xFFCCBEB5)]),
                    ),
                    child: Text(
                      'VIP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ].where((item) => item != null).toList(),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        SizedBox(
          height: 40,
          child: Text(
            this.item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }
  showMovieImage(){
    return new Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(this.item.imgUrl),
                fit: BoxFit.cover
            )
        )
    );
  }

  //NO.1 图标
  numberWidget(var no) {
    return Container(
      child: Text(
        'No.$no',
        style: TextStyle(color: Color.fromARGB(255, 133, 66, 0)),
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 201, 129),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.only(left: 12, top:4),
    );
  }
  //电影标题，星标评分，演员简介Container
  getMovieInfoView(double pWith,BuildContext context) {
    //var start = subject['rating']['average'];
    return Container(
      height: itemHeight,
      width: pWith-100-50,
      padding: EdgeInsets.only(left: 10),
      // alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          //  numberWidget(no + 1),
          getTitleView(),
          DescWidget(this.item.casts,this.item.genres),
          RatingBar(this.item.score),
          buildCommentSection(context),
        ],
      ),
    );
  }
  //分享评论区
  buildCommentSection(BuildContext context){
    return Container(
      //  color: Style.cardColor,
      //  padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 2),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildButtonColumn(Icons.call, 'CALL',context),
          buildButtonColumn(Icons.near_me, 'ROUTE',context),
          buildButtonColumn(Icons.share, 'SHARE',context),
          buildButtonColumn(Icons.star, 'SHARE',context),
        ],
      ),
    );
  }
  //圆角图片
  getImage(var imgUrl) {
    return Container(
      decoration: BoxDecoration(
          image:
          DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      height: itemHeight,
      width: 100.0,
    );
  }
  getStaring(var stars) {
    return Row(
      children: <Widget>[RatingBar(stars), Text('$stars')],
    );
  }
  //肖申克的救赎(1993) View
  getTitleView() {
    // var title = subject['title'];
    // var year = subject['year'];
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            this.item.title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(this.item.year,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))
        ],
      ),
    );
  }
  getMoviePlayUrl(MovieInfo mInfo,BuildContext context){
/*    MovieSearch movieSearch = new MovieSearch("",mInfo.no);
    Future<RespObj> rsp =  HttpUtils.postAwait(Api.MovieDetailUrl,params: json.decode(json.encode(movieSearch)));
    rsp.then((result) {
      print("接口返回的数据是:${result}");
      List li=result.data['playList'];
      this.movieInfo.playUrls=li[0]['playUrl'];
    }).whenComplete((){
      print("异步任务处理完成");

    }).catchError((){
      print("出现异常了");
    });*/

  }
  Column buildButtonColumn(IconData icon, String label,BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color,size: 15,),
        new Container(
          //margin: const EdgeInsets.only(top: 2.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
//类别、演员介绍
class DescWidget extends StatelessWidget {
  var casts;
  var genres;
  DescWidget(this.casts,this.genres);
  @override
  Widget build(BuildContext context) {
    // var casts = subject['casts'];
    var sb = StringBuffer();
    //  var genres = subject['genres'];
    for (var i = 0; i < genres.length; i++) {
      sb.write('${genres[i]}  ');
    }
    sb.write("/ ");
/*    List<String> list = List.generate(
        casts.length, (int index) => casts[index]['name'].toString());

    for (var i = 0; i < list.length; i++) {
      sb.write('${list[i]} ');
    }*/
    return Container(
      child: Text(
        sb.toString(),
        softWrap: true,
        textDirection: TextDirection.ltr,
        style:
        TextStyle(fontSize: 16, color: Color.fromARGB(255, 118, 117, 118)),
      ),
    );
  }
}
class RatingBar extends StatelessWidget {
  String stars;
  RatingBar(this.stars);
  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    double dstars = double.parse(stars);
    //实心星星
    var startNumber = dstars ~/ 2;
    //半实心星星
    var startHalf = 0;
    if (dstars.toString().contains('.')) {
      int tmp = int.parse((dstars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: 18,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 18,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 18,
      ));
    }
    startList.add(Text(
      '$stars',
      style: TextStyle(
        color: Colors.grey,
      ),
    ));
    return Container(
      // alignment: Alignment.bottomCenter,
      // color: Style.cardColor,
      margin: const EdgeInsets.only(top: 30.0),
      // padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: startList,
      ),
    );
  }
}
class Helper {

  static String numFormat(int num) {

    if (num / 10000 < 1) {

      return 'num';

    } else if (num / 100000000 < 1) {

      return '${num ~/ 10000}万';

    } else {

      return '${num ~/ 100000000}亿';

    }

  }

}

