import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/data/entity/video_entity.dart';
//import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/util/time_util.dart';

class HomePageItem extends StatelessWidget {
  final Item item;

  HomePageItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: CachedNetworkImage(
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: item.imgUrl,
                    errorWidget: (context, url, error) =>
                        Image.asset('images/img_load_fail.png'),
                  ),
                  onTap: () {
                    String itemJson =
                        FluroConvertUtils.object2string(this.item);
                    RouterManager.router.navigateTo(
                      context,
                      RouterManager.video + "?itemJson=$itemJson",
                      transition: TransitionType.inFromRight,
                    );
                  },
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 10,
                      bottom: 10,
                      right: 15,
                    ),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 35,
                              height: 35,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  item.category,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                // color: Color(0x4DFAEBD7),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x4DCD8C95),
                                    Color(0x4DF0FFFF)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  TimeUtil.formatDuration(item.createTime),
                                  style: TextStyle(
                                    fontSize: 10,
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
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      String itemJson = FluroConvertUtils.object2string(item);
                      RouterManager.router.navigateTo(
                        context,
                        RouterManager.author + "?itemJson=$itemJson",
                        transition: TransitionType.inFromRight,
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: item.imgUrl,
                      width: 40,
                      height: 40,
                      placeholder: (context, url) => CircularProgressIndicator(
                        strokeWidth: 2.5,
                        backgroundColor: Colors.deepPurple[600],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 15,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "spping",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                GestureDetector(
                  child: Image.asset(
                    'images/icon_share.png',
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
