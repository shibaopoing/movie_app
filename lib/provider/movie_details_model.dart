import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/pages/player/video_player.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/urlUtl.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
class MovieDetailsModel extends ChangeNotifier {
  //List<Item> itemList = [];
  String playUrl;
  int id;
  bool isInit;
  List<int> backColor;
  MovieInfo movieInfo;
  //VideoPlayer videoPlayer;
  List<Map> widgets =new List();
  /// 初始化
  init(id) async {
    this.id = id;
    initPage(true);
    await loadData(this.id );
  }

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 加载数据
  Future<List<Map>> loadData(int id) async {
    try {
      MovieSearch movieSearch = new MovieSearch("",1,id);
      var response = await HttpUtils.postAwait(Url.MovieDetailUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      this.movieInfo = MovieInfo.fromJson(map);
      // 提取网络图片的主要颜色
      backColor=await getColorFromUrl(this.movieInfo.imgUrl,10);
      List list = map['playList'];
      if(playUrl==null){
        playUrl =list[0]['playUrl'];
      }
      list.forEach((item) {
        Map mm = new Map();
        mm.putIfAbsent("title", ()=>item['playName']);
        mm.putIfAbsent("value", ()=>item['playUrl']);
        mm.putIfAbsent("color", ()=>Color.fromARGB(0,backColor[0],backColor[1],backColor[2]));
        mm.putIfAbsent("playColor", ()=>Colors.white);
        this.widgets.add(mm);
      });
      //this.videoPlayer = new VideoPlayer(videoUrl:this.playUrl,title: this.movieInfo.title,);
     // this.widgets = list;
      notifyListeners();
      return this.widgets;
    } catch (e, s) {
      return null;
    }
  }
  Future setPlayItem(String newUrl) async{
    if(this.playUrl==newUrl){
      return;
    }
    //this.videoPlayer =null;
    this.playUrl =newUrl;
    notifyListeners();
  }
}

