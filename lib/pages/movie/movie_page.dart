import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/pages/home/time_title_item.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/provider/movie_page_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:movie_app/widget/search/search_bar.dart' as search_bar;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'movie_page_item.dart';
class MoviePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  State<StatefulWidget> createState() => MoviePageState();
}
class MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<MoviePageModel>(
      model: MoviePageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          key: widget.scaffoldKey,
          body: Container(
            color: Color(0xFFF4F4F4),
            child: RefreshConfiguration(
              enableLoadingWhenNoData: false,
              child: SmartRefresher(
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No11 more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                enablePullUp: true,
                controller: model.refreshController,
                onRefresh: model.onRefresh,
                onLoading: model.onLoadMore,
                child: Container(
                  child: MoviePageListWidget(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
class MoviePageListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviePageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return GridView.builder(
      itemCount:model.dataList.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:3,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        var item = MovieInfo.fromJson(model.dataList[index]) ;
          return MoviePageItem(item: item);
      },
    );
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = MovieInfo.fromJson(model.dataList[index]) ;
        if (item.title == 'textHeader') {
          return TimeTitleItem(timeTitle: item.title);
        }
        return MoviePageItem(item: item);
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