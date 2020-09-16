import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/data/remote_repository.dart';
import 'package:movie_app/pages/movie/movie_page.dart';
import 'package:movie_app/pages/shortVideo/video_list_page.dart';
import 'package:movie_app/provider/refresh_loadmore_model.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/logger_util.dart';

class HomePageModel<Item> extends RefreshLoadMoreModel {
  List <Map> itemTabs;
  List <Widget> itemViews;
  String searchKey;
  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("HomePageModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");
/*    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);
    Map map = json.decode(response.toString());
    var issueEntity = IssueEntity.fromJson(map);
    nextPageUrl = issueEntity.nextPageUrl;
    var list = issueEntity.issueList[0].itemList;
    list.removeWhere((item) {
      return item.type == 'banner2';
    });*/
/*    MovieSearch movieSearch = new MovieSearch("",currentPageNum,0);
    var response = await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
*//*    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);*//*
    RspObj rspObj = response;
    Map map = rspObj.data;
    int totalPage = map['totalPage'];
    if(currentPageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="false";
    }
    var list = map['rows'];*/
    itemTabs = new List();
    itemTabs..add({"title":"电影","index":1})..add({"title":"电视剧","index":2})..add({"title":"短视频","index":3});
    itemViews = new List();
    itemViews..add(MoviePage())..add(MoviePage())..add(VideoListPage());
    searchKey ="";
    LoggerUtil.instance().v("HomePageModel http success ---> ${itemTabs.toString()}");
    return itemTabs;
  }

  @override
  Future<List> onRefresh() {
    isRefresh = true;
    return loadRemoteData();
  }

  @override
  Future<List> onLoadMore() {
    isRefresh = false;
    return loadRemoteData();
  }
  void setSearchKey(String searchKey){
    this.searchKey = searchKey;
    notifyListeners();
  }
  /*Future<List<Item>> loadBanner() async {
    try {
      var response = await EptRepository.getHomePageList(Constant.homePageUrl);
      Map map = json.decode(response.toString());
      var issueEntity = IssueEntity.fromJson(map);
      nextPageUrl = issueEntity.nextPageUrl;
      await loadData(url: nextPageUrl);
      var list = issueEntity.issueList[0].itemList;
      list.removeWhere((item) {
        return item.type == 'banner2';
      });
      bannerList.clear();
      bannerList.addAll(list);
      return bannerList;
    } catch (e, s) {
      return null;
    }
  }*/

}
