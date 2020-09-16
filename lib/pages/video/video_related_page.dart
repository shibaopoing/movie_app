import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/util/time_util.dart';

class VideoRelatedPage extends StatelessWidget {
  final Item item;
  final callback;

  VideoRelatedPage({Key key,@required this.item, @required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.callback(this.item);
/*        String itemJson = FluroConvertUtils.object2string(this.item);
        RouterManager.router.navigateTo(
          context,
          RouterManager.video + "?itemJson=$itemJson",
          transition: TransitionType.inFromRight,
        );*/
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
              child: Stack(
                alignment: FractionalOffset(0.95, 0.90),
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: item.imgUrl,
                      width: 135,
                      height: 80,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          TimeUtil.formatDuration(168),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child:Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      // padding: EdgeInsets.only(top: 15),
                      Text(
                        '#${item.category} / ${item.title}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: RatingBar(item.score),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: buildCommentSection(context,item)
                      )
                    ],
                  ),
                )

            ),
/*            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Container(
                color:Color(0xFFF4F4F4),
              ),
            )*/
          ],
        ),
      ),
    );
  }

  //分享评论区
  buildCommentSection(BuildContext context,Item item){
    return Container(
      //  color: Style.cardColor,
      //  padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 2),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildButtonColumn(Icons.play_arrow, 'CALL',context),
          //buildButtonColumn(Icons.near_me, 'ROUTE',context),
          buildButtonColumn(Icons.share, 'SHARE',context),
          buildButtonColumn(Icons.star, 'SHARE',context),
        ],
      ),
    );
  }
  Column buildButtonColumn(IconData icon, String label,BuildContext context) {
    Color color = Colors.black;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        new Icon(icon, color: color,size: 10,),
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
        size: 12,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 12,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 12,
      ));
    }
/*    startList.add(Text(
      '$stars',
      style: TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
    ));*/
    return Container(
      // alignment: Alignment.bottomCenter,
      // color: Style.cardColor,
      //margin: const EdgeInsets.only(top: 30.0),
      // padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: startList,
      ),
    );
  }
}