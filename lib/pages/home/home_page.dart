import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/pages/home/leftDrawer.dart';
import 'package:movie_app/pages/home/search_frame.dart';
import 'package:movie_app/pages/movie/movie_page.dart';
import 'package:movie_app/provider/movie_page_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/util/httpUtils.dart';
import 'package:movie_app/util/urlUtl.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';

import 'home_page_item.dart';
import '../../provider/home_page_model.dart';
import 'time_title_item.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageModel>(
        model: HomePageModel(),
        onModelInitial: (model) {
          model.init();
        },
        builder: (context, model, child) {
          return DefaultTabController(
            length: model.itemTabs.length,
            child: Scaffold(
              key: _scaffoldKey,
              appBar:AppBar(
                title: SearchFrame(model),
                centerTitle: true,
                backgroundColor: Colors.white,
                /// 去除阴影
                elevation: 0,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.dashboard, color: Colors.black), //自定义图标
                    onPressed: () {
                      // 打开抽屉菜单
                      //  Scaffold.of(context).openDrawer();
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                actions: <Widget>[
                  IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0.0),
                    icon: Icon(
                      Icons.photo_camera,
                      color: Colors.black87,
                    ),
                    onPressed: () {
/*                      String searchKey = model.searchKey;
                      if(null==searchKey||searchKey==""){
                        return;
                      }
                      Map<String,String> paramMap = new Map();
                      paramMap.putIfAbsent("searchKey", ()=>searchKey);
                      paramMap.putIfAbsent("categoryId", ()=>"2");
                      HttpUtils.post(Url.SearchDetailUrl,success,context,json.decode(json.encode(paramMap)),fail);*/
                    },
                  ),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  tabs: model.itemTabs.map((Map itemTab){
                    return Tab(
                      text: itemTab['title'],
                    );
                  }).toList(),
                ),
              ),
              drawer: new LeftDrawer(),
              body: TabBarView(
                children:model.itemViews.map((Widget itemView){
                  return itemView;
                }).toList(),
              ),
            ),
          );
        },
    );
    return ProviderWidget<HomePageModel>(
      model: HomePageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        void success(RspObj rspObj){
          print(rspObj.data);
          int index= DefaultTabController.of(_scaffoldKey.currentContext).index;
          if(index==0){
            //Provider.of<MoviePageModel<dynamic>>(context, listen: false).setData(rspObj.data);
            //model.setData(rspObj.data);
            MoviePage widget =model.itemViews[0];
            MoviePageModel mp = Provider.of(widget.scaffoldKey.currentContext);
            mp.setData(rspObj.data);
          }
        }
        void fail(RspObj rspObj){
          print(rspObj.code);
        }
        return DefaultTabController(
          length: model.itemTabs.length,
          child: Scaffold(
            key: _scaffoldKey,
            appBar:AppBar(
              title: SearchFrame(model),
              centerTitle: true,
              backgroundColor: Colors.white,
              /// 去除阴影
              elevation: 0,
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.dashboard, color: Colors.black), //自定义图标
                  onPressed: () {
                    // 打开抽屉菜单
                    //  Scaffold.of(context).openDrawer();
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
              actions: <Widget>[
                IconButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 0.0),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    String searchKey = model.searchKey;
                    if(null==searchKey||searchKey==""){
                      return;
                    }
                    Map<String,String> paramMap = new Map();
                    paramMap.putIfAbsent("searchKey", ()=>searchKey);
                    paramMap.putIfAbsent("categoryId", ()=>"2");
                    HttpUtils.post(Url.SearchDetailUrl,success,context,json.decode(json.encode(paramMap)),fail);
                  },
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: model.itemTabs.map((Map itemTab){
                  return Tab(
                    text: itemTab['title'],
                  );
                }).toList(),
              ),
            ),
            drawer: new LeftDrawer(),
            body: TabBarView(
              children:model.itemViews.map((Widget itemView){
                  return itemView;
              }).toList(),
            ),
          ),
        );
      },
    );

  }
  @override
  bool get wantKeepAlive => true;
}

class HomePageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomePageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = model.dataList[index];
        if (item.type == 'textHeader') {
          return TimeTitleItem(timeTitle: item.data.text);
        }
        return HomePageItem(item: item);
      },
      separatorBuilder: (context, index) {
        var item = model.dataList[index];
        var itemNext = model.dataList[index + 1];
        if (item.type == 'textHeader' || itemNext.type == 'textHeader') {
          return Divider(
            height: 0,
            color: Color(0xFFF4F4F4),

            /// indent: 前间距, endIndent: 后间距
          );
        }
        return Divider(
          height: 10,
          color: Color(0xFFF4F4F4),

          /// indent: 前间距, endIndent: 后间距
        );
      },
      itemCount: model.dataList.length,
    );
  }
}
