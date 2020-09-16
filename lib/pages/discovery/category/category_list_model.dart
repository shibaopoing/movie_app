import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:movie_app/data/entity/category_entity.dart';
import 'package:movie_app/data/entity/issue_entity.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/data/entity/movie_Search.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/data/remote_repository.dart';
import 'package:movie_app/provider/refresh_loadmore_model.dart';
import 'package:movie_app/util/constant.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/logger_util.dart';
import 'package:movie_app/util/urlUtl.dart';

import '../movie_discovery_page.dart';
import 'sortConditon.dart';

class CategoryListModel<Item> extends RefreshLoadMoreModel {
  //视频大类ID
  final int id;
  CategoryEntity currentCategory;
  //主要分类列表
  List <CategoryEntity> categoryList;
  List<List<MovieInfo>> movieList = new List();
  //年代列表
  List <SortCondition> years;
  //明星列表
  List <SortCondition> actors;
  //地域列表
  List <SortCondition> areas;
  CategoryListModel(this.id);

  @override
  Future<List> loadData() async {
/*    var response = await Repository.getCategoryList(
        isRefresh ? Constant.categoryDetailsUrl : nextPageUrl, id);
    Map map = json.decode(response.toString());
    var issueEntity = Issue.fromJson(map);
    nextPageUrl = issueEntity.nextPageUrl;
    var list = issueEntity.itemList;
    return list;*/
    if(isInit){
      if(null==this.categoryList){
        this.categoryList = new List();
      }
      if(this.years==null){
        this.years = new List();
      }
      if(this.areas==null){
        this.areas = new List();
      }
      if(this.actors==null){
        this.actors = new List();
      }
      CategoryEntity entity0 = new CategoryEntity();
      entity0.bgPicture = "";
      entity0.name="全部";
      CategoryEntity entity = new CategoryEntity();
      entity.id=0;
      entity.bgPicture = "";
      entity.name="科幻";
      entity.pageNum=1;
      CategoryEntity entity2 = new CategoryEntity();
      entity2.id=1;
      entity2.bgPicture = "";
      entity2.name="动作";
      entity2.pageNum=1;
      CategoryEntity entity3 = new CategoryEntity();
      entity3.id=2;
      entity3.bgPicture = "";
      entity3.name="惊悚";
      entity3.pageNum=1;
      CategoryEntity entity4 = new CategoryEntity();
      entity4.id=3;
      entity4.bgPicture = "";
      entity4.name="喜剧";
      entity4.pageNum=1;
      CategoryEntity entity5 = new CategoryEntity();
      entity5.id=4;
      entity5.bgPicture = "";
      entity5.name="悬疑";
      entity5.pageNum=1;
      CategoryEntity entity6 = new CategoryEntity();
      entity6.id=5;
      entity6.bgPicture = "";
      entity6.pageNum=1;
      entity6.name="战争";
      this.categoryList.add(entity0);
      this.categoryList.add(entity);
      this.categoryList.add(entity2);
      this.categoryList.add(entity3);
      this.categoryList.add(entity4);
      this.categoryList.add(entity5);
      this.categoryList.add(entity6);

      years.add(SortCondition(name: "2020",id:"2020",isSelected: false));
      years.add(SortCondition(name: "2019",id:"2019",isSelected: false));
      years.add(SortCondition(name: "2018",id:"2018",isSelected: false));
      years.add(SortCondition(name: "2017",id:"2017",isSelected: false));
      years.add(SortCondition(name: "2016",id:"2016",isSelected: false));
      years.add(SortCondition(name: "2015",id:"2015",isSelected: false));

      actors.add(SortCondition(name: "成龙",id:"cl",isSelected: false));
      actors.add(SortCondition(name: "李连杰",id:"llj",isSelected: false));
      actors.add(SortCondition(name: "张子丹",id:"zzd",isSelected: false));
      actors.add(SortCondition(name: "赵文卓",id:"zwz",isSelected: false));
      actors.add(SortCondition(name: "吴京",id:"wj",isSelected: false));

      areas.add(SortCondition(name: "大陆",id:"dl",isSelected: false));
      areas.add(SortCondition(name: "香港",id:"zg",isSelected: false));
      areas.add(SortCondition(name: "日韩",id:"rh",isSelected: false));
      areas.add(SortCondition(name: "欧美",id:"om",isSelected: false));
      this.categoryList.forEach((f)  {
        this.movieList.add(null);
      });
      this.currentCategory = categoryList[0];
    }else{
    }
    if(isRefresh){
      currentCategory.pageNum=1;
      await loadCategoryList(currentCategory,false,true);
    }else{
      currentCategory.pageNum = currentCategory.pageNum+1;
      await loadCategoryList(currentCategory,false,false);
    }
    return areas;
  }

  @override
  Future<List> onRefresh() async {
    isRefresh = true;
    return await loadRemoteData();
  }

  @override
  Future<List> onLoadMore()async {
    isRefresh = false;
    return  await loadRemoteData();
  }
  Future<List> loadCategoryList(CategoryEntity entity,bool isInit,bool isRefresh) async{
    LoggerUtil.instance().d("MoviePageModel start http ---> ${isRefresh ? Constant.homePageUrl : nextPageUrl}");
    MovieSearch movieSearch = new MovieSearch("",entity.pageNum,0);
    var response =  await HttpUtils.postAwait(Url.MovieUrl,params: json.decode(json.encode(movieSearch)));
/*    var response = await Repository.getHomePageList(
        isRefresh ? Constant.homePageUrl : nextPageUrl);*/
    RspObj rspObj = response;
    Map map = rspObj.data;
    int totalPage = map['totalPage'];
    if(entity.pageNum<totalPage){
      nextPageUrl="true";
    }else{
      nextPageUrl="false";
    }
    List list = map['rows'];
    List<MovieInfo> movies =  list.map((v) => MovieInfo.fromJson(v)).toList();
    if(isRefresh){
      if(this.movieList[currentCategory.id]!=null&&0<this.movieList[currentCategory.id].length){
        this.movieList[currentCategory.id].clear();
      }
      this.movieList[currentCategory.id]=movies;
    }else{
      this.movieList[currentCategory.id].addAll(movies);
    }
/*    if(isInit){
      this.movieList.add(movies);
    }else{
      if(isRefresh){
        this.movieList[currentCategory.id] = movies;
      }else{
        this.movieList[currentCategory.id].addAll(movies);
      }
    }*/
    notifyListeners();
    LoggerUtil.instance().v("MoviePageModel http success ---> ${map.toString()}");
    return movies;
  }
  void setSelectedCurrentCategory(int index) async {
    isInit=false;
    this.currentCategory = categoryList[index];
    await loadData();
    notifyListeners();
  }
}
