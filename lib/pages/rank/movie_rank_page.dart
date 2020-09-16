import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluro/fluro.dart';
import 'package:movie_app/pages/discovery/hot_item_widget.dart';
import 'package:movie_app/pages/discovery/recommend_item_widget.dart';
import 'package:movie_app/provider/discovery_herald_model.dart';
import 'package:movie_app/provider/discovery_hot_model.dart';
import 'package:movie_app/provider/discovery_last_model.dart';
import 'package:movie_app/provider/discovery_model.dart';
import 'package:movie_app/provider/discovery_recommend_model.dart';
import 'package:movie_app/provider/movie_rank_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/widget/follow_title_widget.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';

/// 发现页
class MovieRankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieRankPageState();
}

class MovieRankPageState extends State<MovieRankPage>
    with AutomaticKeepAliveClientMixin {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<MovieRankModel>(
      model: MovieRankModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        if(model.itemTabs==null){
          return LoadingWidget();
        }
        return DefaultTabController(
          length: model.itemTabs.length,
          child: Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  child:TabBar(
                    isScrollable: true,
                    tabs: model.itemTabs.map((Map itemTab){
                      return Tab(
                        text: itemTab['title'],
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children:model.itemViews.map((Widget itemView){
                      return itemView;
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
