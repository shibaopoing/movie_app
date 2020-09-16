import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/data/remote_repository.dart';
import 'package:movie_app/provider/refresh_loadmore_model.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/logger_util.dart';

class FollowListModel<Item> extends RefreshLoadMoreModel {
  @override
  Future<List> loadData() async {
    LoggerUtil.instance().d("FollowListModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");
    var response = await Repository.getHomePageList(
      isRefresh ? Constant.followUrl : nextPageUrl,
    );
    Map map = json.decode(response.toString());
    var followEntity = Issue.fromJson(map);
    var list = followEntity.itemList;
    this.nextPageUrl = followEntity.nextPageUrl;
    LoggerUtil.instance().v("FollowListModel http success ---> ${map.toString()}");
    return list;
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

}
