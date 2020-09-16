import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:fluro/fluro.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/util/time_util.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
class SearchPageItem extends StatelessWidget {
  final Item item;

  SearchPageItem({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: FractionalOffset(0.5, 0.5),
        children: <Widget>[
          GestureDetector(
            child: CachedNetworkImage(
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: item.imgUrl,
              errorWidget: (context, url, error) =>
                  Image.asset('images/img_load_fail.png'),
            ),
            onTap: () async{
              /// 点击图片跳转至视频详情页
/*              String itemJson = FluroConvertUtils.object2string(this.item);
              RouterManager.router.navigateTo(
                context,
                RouterManager.video + "?itemJson=$itemJson",
                transition: TransitionType.inFromRight,
              );*/
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
            child: Column(
              children: <Widget>[
                Text(
                  item.title,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      TimeUtil.formatDuration(1800),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
