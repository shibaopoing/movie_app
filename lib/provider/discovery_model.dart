import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/pages/discovery/movie_discovery_page.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/logger_util.dart';
import 'package:movie_app/util/urlUtl.dart';

class DiscoveryPageModel extends ChangeNotifier {
  bool isInit;
  List <Map> itemTabs;
  List <Widget> itemViews;
  void initPage(bool isInit) {
    this.isInit = isInit;
  }

  /// 初始化
  init() async {
    initPage(true);
    await loadData();
  }

  /// 加载数据
  Future<List> loadData() async {
    LoggerUtil.instance().d("MoviePageModel start http ---> ${isInit ? Constant.homePageUrl : isInit}");
    itemTabs = new List();
    itemTabs..add({"title":"电影","index":1})..add({"title":"电视剧","index":2});
    itemViews = new List();
    itemViews..add(MovieDiscoveryPage())..add(MovieDiscoveryPage());
    LoggerUtil.instance().v("HomePageModel http success ---> ${itemTabs.toString()}");
    return itemTabs;
   /* MovieSearch movieSearch = new MovieSearch("",currentPageNum,0);
    var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);
    RspObj rspObj = response;
    Map map = rspObj.data;
    int totalPage = map['totalPage'];
    if(currentPageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="false";
    }
    var issueEntity = Video.fromJson(map);
    hotSList =issueEntity.itemList;
    notifyListeners();
    LoggerUtil.instance().v("MoviePageModel http success ---> ${map.toString()}");
    return hotSList;*/
  }
}
