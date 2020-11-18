
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/pages/player/video_player.dart';
import 'package:movie_app/provider/movie_details_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/listTitleCard.dart';
import 'package:movie_app/util/color_thief_flutter.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:movie_app/widget/share_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/// 视频详情页
class MovieDetailsPage extends StatefulWidget {
  final MovieInfo item;
  MovieDetailsPage({Key key,this.item}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MovieDetailsPageState();
}

class MovieDetailsPageState extends State<MovieDetailsPage> {
  //Item item;
  //String videoUrl;
  MovieDetailsModel model =new MovieDetailsModel();
  MovieInfo movieInfo;
  //VideoPlayer videoPlayer;
  @override
  void initState() {
    super.initState();
    if(this.movieInfo==null){
      this.movieInfo =  widget.item;
      /// 修改状态栏字体颜色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
          .copyWith(statusBarBrightness: Brightness.light));
/*      getColorFromUrl(this.movieInfo.imgUrl,10).then((color){
        List<int> backColor = color;
      });*/
      //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      //显示底部栏(隐藏顶部状态栏)
    }
   // WidgetsBinding.instance.addObserver(this);
  }
  /// 释放资源
  @override
  void dispose() {
    if(this.movieInfo!=null){
      this.movieInfo=null;
    }
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //显示顶部栏(隐藏底部栏)
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
  @override
  Widget build(BuildContext context) {
   // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //显示顶部栏(隐藏底部栏)
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return ProviderWidget<MovieDetailsModel> (
      model: this.model,
        onModelInitial: (model) {
        model.init(this.movieInfo.id);
      },
      builder: (context, model, child) {
        Color loadingColor = Color.fromARGB(100,widget.item.backColors[0],widget.item.backColors[1],widget.item.backColors[2]);
        Widget _buildLoadingWidget() {
          return CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(loadingColor),
          );
        }
        return Scaffold(
            body:Container(
              /*color: Color.fromARGB(255,this.backColor[0],this.backColor[1],this.backColor[2]),*/
              /// 设置背景图片
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: <Color>[
                      Color.fromARGB(100,widget.item.backColors[0],widget.item.backColors[1],widget.item.backColors[2]),
                      Color.fromARGB(255,widget.item.backColors[0],widget.item.backColors[1],widget.item.backColors[2])
/*                  this.model.backColor,
                new Color(0xFF736AB7),
                this.model.backColor,*/
                    ],
                    stops: [0.1, 0.9],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(0.0, 0.0),
                  ),
                ),
                child:Container(
                  child:this.model.widgets.length>0?VideoPlayer(movieInfo:this.movieInfo,urls: this.model.widgets):Expanded(child: Center(child: _buildLoadingWidget())),
                )

            )
        );
      },
    );
  }
}
