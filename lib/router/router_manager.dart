import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/pages/author/author_details_page.dart';
import 'package:movie_app/pages/bottom_navigator.dart';
import 'package:movie_app/pages/discovery/category/category_list_page.dart';
import 'package:movie_app/pages/discovery/follow/follow_list_page.dart';
import 'package:movie_app/pages/discovery/more_item_widget.dart';
import 'package:movie_app/pages/movie/movie_details_page.dart';
import 'package:movie_app/pages/splash/splash_page.dart';
import 'package:movie_app/pages/video/video_details_page.dart';
import 'package:movie_app/util/fluro_convert_util.dart';

class RouterManager {
  static Router router;

  /// 启动/欢迎页
  static const String splash = "/";

  /// 底部导航
  static const String navigator = "/navigator";

  /// 视频详情
  static const String video = "/video";
  /// 视频详情
  static const String video2 = "/video2";
  /// 视频列表
  static const String videoList = "/videoList";
  /// 热门分类
  static const String category = "/category";

  /// 推荐关注
  static const String follow = "/follow";

  /// 作者详情
  static const String author = "/author";

  static void configureRouter(Router router) {
    router.notFoundHandler = new Handler(
        // ignore: missing_return
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    router.define(splash, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SplashPage();
    }));
    router.define(navigator, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BottomNavigator();
    }));
    router.define(video, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return VideoDetailsPage(
        itemJson: itemJson,
      );
    }));
    router.define(video2, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          String itemJson = params['itemJson']?.first;
          MovieInfo movieInfo= MovieInfo.fromJson(FluroConvertUtils.string2map(itemJson));
          return MovieDetailsPage(
            item: movieInfo,
          );
    }));
    router.define(videoList, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          String itemJson = params['itemJson']?.first;
          Map param= FluroConvertUtils.string2map(itemJson);
          return MoreItemWidget(
            type: param['type'],
            title: param['title'],
          );
        }));
    router.define(category, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return CategoryListPage(
       // itemJson: itemJson,
      );
    }));
    router.define(follow, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return FollowListPage();
    }));
    router.define(author, handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String itemJson = params['itemJson']?.first;
      return AuthorDetailsPage(
        itemJson: itemJson,
      );
    }));
  }
}
