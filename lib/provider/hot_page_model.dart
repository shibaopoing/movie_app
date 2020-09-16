import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/tab_info_entity.dart';
import 'package:movie_app/http/http.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/dioUtil.dart';
import 'package:movie_app/util/httpUtils.dart';
import '../pages/hot/rank_page.dart';

class HotPageModel extends ChangeNotifier {
  List<Widget> tabPages = [];
  List<TabInfoItem> tabItems = [];

  bool isInit;

  /// 初始化
  init() async {
    _initPage(true);
    await getTabInfo();
  }

  void _initPage(bool isInit) {
    this.isInit = isInit;
    notifyListeners();
  }

  getTabInfo() async {
    try {
      var response =  DioUtil.get(
        Constant.rankListUrl,
        //options: Options(headers: httpHeaders),
      );
      Map map = json.decode(response.toString());
      var tabInfoEntity = TabInfoEntity.fromJson(map);
      this.tabItems = tabInfoEntity.tabInfo.tabList;
      this.tabPages = this
          .tabItems
          .map((tabInfoItem) => RankPage(pageUrl: tabInfoItem.apiUrl))
          .toList();
      _initPage(false);
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}
