import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:movie_app/provider/movie_page_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import '../bottom_navigator.dart';
import 'short_video_model.dart';
import 'video_widget.dart';

class VideoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoListPageState();
}
class VideoListPageState extends State<VideoListPage>
    with  AutomaticKeepAliveClientMixin {
  VideoPlayerController controller;
  int tabIndex;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<ShortVideoModel>(
      model: ShortVideoModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        ShortVideoModel model = Provider.of(context);
        if (model.isInit) {
          return LoadingWidget();
        }
        return Scaffold(
          appBar:AppBar(
            title: Text('短视频'),
            centerTitle: true,
            backgroundColor: Colors.white,
            /// 去除阴影
            elevation: 0,
          ),
          body: Container(
            color: Color(0xFFF4F4F4),
            child: RefreshConfiguration(
              enableLoadingWhenNoData: false,
              child: InViewNotifierList(
                onListEndReached: model.onLoadMore,
                //throttleDuration: Duration(milliseconds: 3000),
                //shrinkWrap: true,
               // physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                initialInViewIds: ['0'],
                isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) && deltaBottom > (0.5 * viewPortDimension);
                },
                itemCount: model.dataList.length,
                builder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return InViewNotifierWidget(
                          id: '$index',
                          builder: (BuildContext context, bool isInView, Widget child) {
                            return VideoWidget(
                              play: isInView,
                              url: model.dataList[index].playUrl,
                              index: index,
                              description: model.dataList[index].title,
                              callBack: currentPlayController,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  void currentPlayController(VideoPlayerController player){
    controller = player;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabIndex= InheritedState.of(context).data;
    if(tabIndex!=1){
      if(controller!=null&&controller.value.isPlaying){
        controller.pause();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  bool get wantKeepAlive => true;
}