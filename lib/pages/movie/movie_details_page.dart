
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/pages/player/video_player.dart';
import 'package:movie_app/provider/movie_details_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/listTitleCard.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
/// 视频详情页
class MovieDetailsPage extends StatefulWidget {
  final MovieInfo item;
  MovieDetailsPage({Key key,this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MovieDetailsPageState();
}

class MovieDetailsPageState extends State<MovieDetailsPage> {
  //Item item;
  //String videoUrl;
  MovieDetailsModel model =new MovieDetailsModel();
  MovieInfo movieInfo;
  @override
  void initState() {
    super.initState();
    if(this.movieInfo==null){
      this.movieInfo =  widget.item;
     // model.init(this.movieInfo .id);
    }
   // WidgetsBinding.instance.addObserver(this);
  }
  /// 获取视频播放地址，并播放，默认播放高清视频
/*  void getVideoUrl(MovieInfo movieInfo) {
    if(videoUrl==null){
      videoUrl= playUrls[0]['playUrl'];
    }
    _controller.setNetworkDataSource(
      videoUrl,
      autoPlay: true,
    );
  }*/
  /// 释放资源
  @override
  void dispose() {
    if(this.movieInfo!=null){
      this.movieInfo=null;
    }
    super.dispose();
  }
  void playThisItem(Map playMap){
    String newUrl=playMap['value'];
    String newName=playMap['title'];
    this.model.setPlayItem(newUrl);
  }
  @override
  Widget build(BuildContext context) {
    /// 修改状态栏字体颜色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarBrightness: Brightness.light));
    /* getColorFromUrl(this.movieInfo.imgUrl,10).then((color){
      List<int> backColor = color;
    });*/
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
   // VideoPlayer  videoPlayer = new  VideoPlayer(videoUrl:this.model.playUrl,title: this.movieInfo.title,);
    //显示底部栏(隐藏顶部状态栏)
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //显示顶部栏(隐藏底部栏)
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    //隐藏底部栏和顶部状态栏
   // SystemChrome.setEnabledSystemUIOverlays([]);
    return ProviderWidget<MovieDetailsModel> (
      model: this.model,
        onModelInitial: (model) {
        model.init(this.movieInfo.id);
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
/*            color: Color.fromARGB(255,this.backColor[0],this.backColor[1],this.backColor[2]),*/
            /// 设置背景图片
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: <Color>[
                  Color.fromARGB(100,widget.item.backColors[0],widget.item.backColors[1],widget.item.backColors[2]),
                  Color.fromARGB(255,widget.item.backColors[0],widget.item.backColors[1],widget.item.backColors[2])
/*                  this.model.backColor,
                  new Color(0xFF736AB7),
                  this.model.backColor,*/
                ],
                stops: [0.1, 0.9],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                /// 视频播放器
                Container(
                  child: VideoPlayer(videoUrl:this.model.playUrl,title: this.movieInfo.title,),
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
                                  this.movieInfo.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
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
                                  this.movieInfo.title,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
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
                                            '${this.movieInfo.score}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
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
                                            '${this.movieInfo.playsCount}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
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
                              ListTitleCard("选集",this.model.widgets,90,60,widget.item.backColors,playThisItem),
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
            ),
          ),
        );
      },
    );
  }
}
class InheritedState extends InheritedWidget {
  final  String data;

  //我们知道InheritedWidget总是包裹的一层，所以它必有child
  InheritedState(
      {Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);
  //定义一个便捷方法，方便子树中的widget获取共享数据
  static InheritedState of(BuildContext context) {
    //return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.dependOnInheritedWidgetOfExactType<InheritedState>();
  }
  //参考MediaQuery,这个方法通常都是这样实现的。如果新的值和旧的值不相等，就需要notify
  @override
  bool updateShouldNotify(InheritedState oldWidget) =>
      data != oldWidget.data;
}
