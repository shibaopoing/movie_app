import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/data/remote_repository.dart';
import 'package:movie_app/pages/rank/rank_day_page.dart';
import 'package:movie_app/pages/rank/rank_month_page.dart';
import 'package:movie_app/pages/rank/rank_week_page.dart';
import 'package:movie_app/provider/refresh_loadmore_model.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/logger_util.dart';
import 'package:movie_app/util/urlUtl.dart';

class MovieRankModel extends RefreshLoadMoreModel {
  List <Map> itemTabs;
  List <Widget> itemViews;
  List <Item> dayItems;
  List <Item> weekItems;
  List <Item> monthItems;
  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("MoviePageModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");
    itemTabs = new List();
    itemTabs..add({"title":"日排行","index":1})..add({"title":"周排行","index":2})..add({"title":"月排行","index":3});
    itemViews = new List();
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
    List list =issueEntity.itemList;
    itemViews..add(RankDayPage(type: "movie",))..add(RankWeekPage(type: "movie",))..add(RankMonthPage(type: "movie",));
    LoggerUtil.instance().v("MoviePageModel http success ---> ${map.toString()}");
    return list;
  }
  void setData( Map map){
    int totalPage = map['totalPage'];
    if(currentPageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="false";
    }
    nextPageUrl="true";
    var list = map['rows'];
    LoggerUtil.instance().v("MoviePageModel http success ---> ${map.toString()}");
    this.dataList = list;
    notifyListeners();
  }
  @override
  Future<List> onRefresh() {
    isRefresh = true;
    currentPageNum=1;
    return loadRemoteData();
  }

  @override
  Future<List> onLoadMore() {
    isRefresh = false;
    currentPageNum=currentPageNum+1;
    return loadRemoteData();
  }

}
