import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/pages/video/video_related_page.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/urlUtl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fluro/fluro.dart';
/// 分类列表
class RankMonthPage extends StatefulWidget {
  final String type;
  RankMonthPage({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RankMonthPageState();
}

class RankMonthPageState extends State<RankMonthPage> {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.noMore,
  );
  List<Item> items;
  bool init = true;
  int currentPage=1;

  @override
  void dispose() {
    this.items.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(this.init){
      onRefresh();
    }
    this.init = false;
  }
  onRefresh() async{
    if(items!=null&&items.length>0){
      items.clear();
    }
    if(widget.type=="movie"){
      MovieSearch movieSearch = new MovieSearch("",1,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items =issueEntity.itemList;
    }
    if(widget.type=="hot"){
      MovieSearch movieSearch = new MovieSearch("",1,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items =issueEntity.itemList;
    }
    if(widget.type=="recommend"){
      MovieSearch movieSearch = new MovieSearch("",1,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items =issueEntity.itemList;
    }
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    setState(() {});
  }
  onLoadMore() async {
    currentPage = currentPage+1;
    if(widget.type=="movie"){
      MovieSearch movieSearch = new MovieSearch("",currentPage,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items.addAll(issueEntity.itemList);
    }
    if(widget.type=="hot"){
      MovieSearch movieSearch = new MovieSearch("",currentPage,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items.addAll(issueEntity.itemList);
    }
    if(widget.type=="recommend"){
      MovieSearch movieSearch = new MovieSearch("",currentPage,0);
      var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      int totalPage = map['totalPage'];
      var issueEntity = Video.fromJson(map);
      this.items.addAll(issueEntity.itemList);
    }
    refreshController.loadComplete();
    setState(() {});
  }
  void playItem(Item item) async{
    item.backColors= await getColorFromUrl(item.imgUrl,10);
    String itemJson = FluroConvertUtils.object2string(item);
    RouterManager.router.navigateTo(
      context,
      RouterManager.video2 + "?itemJson=$itemJson",
      transition: TransitionType.inFromRight,
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor:
        Colors.white, //Changing this will change the color of the TabBar
      ),
      home: Scaffold(
        body: SmartRefresher(
          onRefresh: onRefresh,
          onLoading: onLoadMore,
          enablePullUp: true,
          controller: refreshController,
          header: MaterialClassicHeader(
            distance: 80.0,
            backgroundColor: Colors.redAccent,
          ),
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
/*              SliverAppBar(
                leading: GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    RouterManager.router.pop(context);
                  },
                ),
                //title: Text(widget.title),
                expandedHeight: 0.0,
                pinned: true,
                backgroundColor: Colors.white,
                floating: false,
                snap: false,
*//*                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    item.bgPicture,
                    fit: BoxFit.cover,
                  ),
                ),*//*
              ),*/
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    var i = index;
                    i -= 1;
                    if (i.isOdd) {
                      i = (i + 1) ~/ 2;
                      return VideoRelatedPage(
                        item:this.items[i],
                        callback: this.playItem,
                      );
                    }
                    i = i ~/ 2;
                    return Divider(
                      height: 5,
                      color: Color(0xFFF4F4F4),
                    );

                    // return CategoryListItem(item: model.itemList[index]);
                  },
                  childCount:this.items!=null?this.items.length * 2:0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}