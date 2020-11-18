import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/widget/listTitleCard.dart';
class VideoPlayer extends StatefulWidget {
  final MovieInfo movieInfo;
  final List<Map> urls;
  //final GlobalKey<ScaffoldState> globalKey = new GlobalKey();
  VideoPlayer({Key key,@required this.movieInfo,@required this.urls}) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}
class _VideoPlayerState extends State<VideoPlayer> {
  // String videoUrl = "https://yun.zxziyuan-yun.com/20180221/4C6ivf8O/index.m3u8";
  // String videoUrl = "http://vodkgeyttp8.vod.126.net/cloudmusic/1241/core/e30b/aec700ee466da6c8ce51d12953e7b89f.mp4?wsSecret=a6d7342a3ea018d632b3d7ce56ffd11f&wsTime=1580815486";
  // String videoUrl = "http://vod.anyrtc.cc/364c01b9c8ca4e46bd65e7307887341d/34688ef93da349628d5e4efacf8a5167-9fd7790c8f5862b09c350e4a916b203d.mp4";
  BetterPlayerController _betterPlayerController;
  Color loadingColor;
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    loadingColor= Color.fromARGB(255,widget.movieInfo.backColors[0],widget.movieInfo.backColors[1],widget.movieInfo.backColors[2]);
    var playUrl =widget.urls[0]['value'];
    BetterPlayerControlsConfiguration controlsConfiguration =
    BetterPlayerControlsConfiguration(
      controlBarColor: loadingColor,//Colors.indigoAccent.withAlpha(200),
      iconsColor: Colors.lightGreen,
      playIcon: Icons.forward,
      progressBarPlayedColor: Colors.grey,
      progressBarHandleColor: Colors.lightGreen,
      enableSkips: false,
      enableFullscreen: true,
      controlBarHeight: 30,
    );
    BetterPlayerConfiguration betterPlayerConfiguration =
    BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        controlsConfiguration: controlsConfiguration);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK, playUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.addListener(_playerInitialize);
/*    betterPlayerController.addEventsListener((event){
      print("Better player event: ${event.betterPlayerEventType}");
    });
    betterPlayerController.addListener((){
      print("...Better player event.....:");
    });*/
  }
  void _playerInitialize() async {
    if (_betterPlayerController.videoPlayerController.value.isPlaying) {
      setState(() {
        isLoading = false;
      });
      _betterPlayerController.removeListener(_playerInitialize);
    }
  }
  void playThisItem(Map playMap){
    String newUrl=playMap['value'];
    //betterPlayerController.removeListener(_playerInitialize);
    _betterPlayerController.videoPlayerController.setNetworkDataSource(newUrl);
    _betterPlayerController.videoPlayerController.play();
    setState(() {
      //isLoading = true;
    });
   // betterPlayerController.addListener(_playerInitialize);
  }
  @override
  Widget build(BuildContext context) {

    Widget _buildLoadingWidget() {
      return Center(
          child:Container(
            child:CircularProgressIndicator(
              // value: 0.3,
              valueColor: AlwaysStoppedAnimation<Color>(this.loadingColor),
            ),
          )
      );
    }
    return SafeArea(
        top:true,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,  //分析 2
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child:BetterPlayer(controller: this._betterPlayerController),
/*              child: BetterPlayer(
                controller: this.betterPlayerController
              ),*/
                  ),
                ),
               // _buildLoadingWidget(),
              ],
            ),
            Flexible(
              flex: 1,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// 标题栏
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                              bottom: 5,
                            ),
                            child: Text(
                              widget.movieInfo.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),

                          /// 标签/时间栏
                          /*                             Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  '#${this.movieInfo.title} / ${DateUtil.formatDateMs(item.data.author.latestReleaseTime, format: 'yyyy/MM/dd HH:mm')}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),*/

                          /// 视频描述
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            child: Text(
                              widget.movieInfo.title,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),

                          /// 点赞、分享、评论栏
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/icon_like.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        '${widget.movieInfo.score}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/icon_share_white.png',
                                        width: 22,
                                        height: 22,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3),
                                        child: Text(
                                          '${100}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'images/icon_comment.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        '${widget.movieInfo.playsCount}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

/*                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Divider(
                                  height: .5,
                                  color: Color(0xFFDDDDDD),
                                ),
                              ),*/

                          /// 作者信息
                          /*InkWell(
                                onTap: () {
                                  String itemJson =
                                      FluroConvertUtils.object2string(
                                          item);
                                  RouterManager.router.navigateTo(
                                    context,
                                    RouterManager.author +
                                        "?itemJson=$itemJson",
                                    transition: TransitionType.inFromRight,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    right: 15,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          width: 40,
                                          height: 40,
                                          imageUrl:
                                              item.data.author.icon,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            backgroundColor:
                                                Colors.deepPurple[600],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                item.data.author.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3),
                                                child: Text(
                                                  item.data.author
                                                      .description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '+ 关注',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        onTap: (() {
                                          print('点击关注');
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),*/

                          Divider(
                            height: .5,
                            color: Color(0xFFDDDDDD),
                          ),
                          ListTitleCard(title:"选集",members:widget.urls,listWith:90,listHeight:60,backColor:widget.movieInfo.backColors,callback:playThisItem),
                          Divider(
                            height: .5,
                            color: Color(0xFFDDDDDD),
                          ),

                        ],
                      ),
                    ),
                  ),
                  /// 相关视频列表
                  /*SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (model.itemList[index].type ==
                                'videoSmallCard') {
                              return VideoRelatedPage(
                                item: model.itemList[index],
                                callback: () {
                                  if (this.model.chewieController.isLive) {
                                    this.model.chewieController.pause();
                                  }
                                },
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 15, top: 10, bottom: 10),
                              child: Text(
                                model.itemList[index].data.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                          childCount: model.itemList.length,
                        ),
                      ),*/
                ],
              ),
            ),
          ],
        )
    );
  }
  void clear(){
      Navigator.pop(context);
  }
}


