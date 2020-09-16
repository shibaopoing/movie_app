import 'dart:convert';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/short_video.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/data/remote_repository.dart';
import 'package:movie_app/provider/refresh_loadmore_model.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/logger_util.dart';
import 'package:movie_app/util/urlUtl.dart';

class ShortVideoModel extends RefreshLoadMoreModel {

  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("MoviePageModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");

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
    ShortVideo info = new ShortVideo.empty();
    info.playUrl="https://vt1.doubanio.com/202006022150/ebf60b5c33539fc7687f5af88da59ee9/view/movie/M/402600682.mp4";
    info.title="艾莉楚";
    List<ShortVideo> items =List.generate(5, (index) => info);
    totalPage =3;
    if(currentPageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="";
    }
    LoggerUtil.instance().v("MoviePageModel http success ---> ${items.toString()}");
    return items;
  }
  void setData( Map map){
    int totalPage = map['totalPage'];
    if(currentPageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="";
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
