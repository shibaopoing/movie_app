import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/entity/category_entity.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/http/http.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/logger_util.dart';
import 'package:movie_app/util/urlUtl.dart';

class DiscoveryRecommendModel extends ChangeNotifier {
  bool isInit;

  List<Item> lastList;

  String nextPageUrl;

  void initPage(bool isInit) {
    this.isInit = isInit;
  }

  /// 初始化
  init() async {
    initPage(true);
    await loadData();
  }

  /// 加载数据
  loadData() async {
    LoggerUtil.instance().d("MoviePageModel start http ---> ${isInit ? Constant.homePageUrl : isInit}");

    MovieSearch movieSearch = new MovieSearch("",1,0);
    var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
/*    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);*/
    RspObj rspObj = response;
    Map map = rspObj.data;
    int totalPage = map['totalPage'];
    if(1<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="false";
    }
    var issueEntity = Video.fromJson(map);
    lastList =issueEntity.itemList;
    notifyListeners();
    LoggerUtil.instance().v("MoviePageModel http success ---> ${map.toString()}");
  }
}
