import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/http/http.dart';
import 'package:movie_app/util/constant.dart';

class DiscoveryFollowModel extends ChangeNotifier {
  bool isInit;
  String nextPageUrl;

  List<Item> followItemList;

  /// 初始化
  init() async {
    await loadData();
  }

  /// 加载数据
  loadData({String url}) async {
    try {
      /// 发起并发请求
      var response = await HttpUtil.buildDio().get(
        Constant.followUrl,
        options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var followEntity = Issue.fromJson(map);
      nextPageUrl = followEntity.nextPageUrl;
      var followItemList = followEntity.itemList;

      this.followItemList = followItemList;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }

  loadNextPage() async {
    try {
      var response = await HttpUtil.buildDio().get(
        null == nextPageUrl ? Constant.followUrl : nextPageUrl,
        options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var followEntity = Issue.fromJson(map);
      nextPageUrl = followEntity.nextPageUrl;
      var followItemList = followEntity.itemList;
      this.followItemList = followItemList;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }
}
