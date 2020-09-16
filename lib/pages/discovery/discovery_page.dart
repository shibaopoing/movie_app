import 'package:flutter/material.dart';
import 'package:movie_app/provider/discovery_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/loading_widget.dart';


/// 首页
class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<DiscoveryPageModel>(
      model: DiscoveryPageModel(),
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
