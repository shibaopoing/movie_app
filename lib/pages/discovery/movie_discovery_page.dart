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
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:movie_app/widget/follow_title_widget.dart';
import 'package:provider/provider.dart';
import 'herald_item_widget.dart';
import 'last_item_widget.dart';

/// 发现页
class MovieDiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<MovieDiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    void lastMoreItem(){
      String itemJson = FluroConvertUtils.object2string({"type":"last","title":"上新"});
      RouterManager.router.navigateTo(
        context,
        RouterManager.videoList+ "?itemJson=$itemJson",
        transition: TransitionType.inFromRight,
      );
    }
    void recommendMoreItem(){
      String itemJson = FluroConvertUtils.object2string({"type":"recommend","title":"推荐"});
      RouterManager.router.navigateTo(
        context,
        RouterManager.videoList+ "?itemJson=$itemJson",
        transition: TransitionType.inFromRight,
      );
    }
    void hotMoreItem(){
      String itemJson = FluroConvertUtils.object2string({"type":"hot","title":"热门"});
      RouterManager.router.navigateTo(
        context,
        RouterManager.videoList+ "?itemJson=$itemJson",
        transition: TransitionType.inFromRight,
      );
    }
    void heraldMoreItem(){
      String itemJson = FluroConvertUtils.object2string({"type":"hot","title":"精彩预告片"});
      RouterManager.router.navigateTo(
        context,
        RouterManager.videoList+ "?itemJson=$itemJson",
        transition: TransitionType.inFromRight,
      );
    }
    return ProviderWidget4<DiscoveryHotModel,DiscoveryLastModel,DiscoveryRecommendModel,DiscoveryHeraldModel>(
     // key: _scaffoldKey,
      model1: DiscoveryHotModel(),
      model2: DiscoveryLastModel(),
      model3: DiscoveryRecommendModel(),
      model4: DiscoveryHeraldModel(),
      onModelInitial: (model1,model2,model3,model4) {
        model1.init();
        model2.init();
        model3.init();
        model4.init();
      },
      builder: (context, model1, model2,model3,model4,child) {
        return Container(
          color: Colors.white,
          child: EasyRefresh.custom(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child:FollowTitleWidget(title:'最近更新',callback: lastMoreItem,more:true),
              ),
              SliverToBoxAdapter(
                child: Container(
/*                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 12,
                    ),*/
                  child: Consumer<DiscoveryPageModel>(
                    builder: (context, model, child) {
                      return LastItemWidget(items:model2.lastList);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child:FollowTitleWidget(title:'精彩预告',callback: heraldMoreItem,more:true),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Consumer<DiscoveryHeraldModel>(
                    builder: (context, model, child) {
                      return HeraldItemWidget(items:model4.heraldList);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),

              SliverToBoxAdapter(
                child:FollowTitleWidget(title:'强力推荐',callback: recommendMoreItem,more:true),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Consumer<DiscoveryHotModel>(
                    builder: (context, model, child) {
                      return RecommendItemWidget(items:model2.lastList);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  width: double.infinity,
                  height: 8,
                ),
              ),
              SliverToBoxAdapter(
                child: FollowTitleWidget(title:'观看热门',callback: hotMoreItem,more:true),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: Consumer<DiscoveryHotModel>(
                    builder: (context, model, child) {
                      return HotItemWidget(items:model2.lastList);
/*                      return Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.hotList.length,
                          itemBuilder: (context, index) {
                            return VideoRelatedPage(
                              item: model.hotList[index],
                            );
                          },
                        ),
                      );*/
                    },
                  ),
                ),
              ),
         /*     SliverPadding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                sliver: SliverToBoxAdapter(
                  child: Consumer<DiscoveryPageModel>(
                    builder: (context, model, child) {
                      return Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 70,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: InkWell(
                            onTap: () {
                              //model.loadNextPage();
                            },
                            child: Text(
                              '换一换',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),*/
            ],
          ),
        );
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}
