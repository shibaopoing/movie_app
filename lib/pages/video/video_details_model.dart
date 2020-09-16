import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
//import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/entity/video_entity.dart';
import 'package:movie_app/http/http.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/urlUtl.dart';

class VideoDetailsModel extends ChangeNotifier {
  //List<Item> itemList = [];
  MovieInfo movieInfo;
  int id;
  bool isInit;

  /// 初始化
  init(id) async {
    this.id = id;
    initPage(true);
    await loadData();
  }

  void initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  /// 加载数据
  Future<List<Item>> loadData() async {
    try {
/*      var response = await HttpUtil.buildDio().get(
        Constant.videoRelatedUrl,
        queryParameters: {
          "id": this.id,
        },
        options: Options(
          headers: httpHeaders,
        ),
      );
      Map map = json.decode(response.toString());
      var issue = Issue.fromJson(map);
      itemList = issue.itemList;
      if (isInit) {
        initPage(false);
      }
      notifyListeners();
      return itemList;*/
      MovieSearch movieSearch = new MovieSearch("",1,id);
      var response = await HttpUtils.postAwait(Url.MovieDetailUrl,params: json.decode(json.encode(movieSearch)));
      RspObj rspObj = response;
      Map map = rspObj.data;
      List list = map['playList'];
      this.movieInfo = MovieInfo.fromJson(map);
      return list;
      notifyListeners();
    } catch (e, s) {
      return null;
    }
  }
}
