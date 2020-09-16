import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:movie_app/provider/author_main_page_model.dart';
import 'package:movie_app/pages/discovery/follow/follow_item_details_widget.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'collection_card.dart';
import 'video_welcom_page.dart';

/// 作者首页
class AuthorMainPage extends StatefulWidget {
  final String apiUrl;

  AuthorMainPage({Key key, this.apiUrl});

  @override
  State<StatefulWidget> createState() => AuthorMainPageState();
}

class AuthorMainPageState extends State<AuthorMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<AuthorMainPageModel>(
      model: AuthorMainPageModel(),
      onModelInitial: (model) {
        model.init(widget.apiUrl);
      },
      builder: (context, model, child) {
        if (model.isInit) {
          return LoadingWidget();
        }
        return AuthorMainPageWidget();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AuthorMainPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final GlobalKey<ScaffoldState> _stackKey = new GlobalKey<ScaffoldState>();
    GZXDropdownMenuController _dropdownMenuController = new GZXDropdownMenuController();
    return Container(
      key: _scaffoldKey,
      child:   GZXDropDownHeader(    // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
        items: [
          GZXDropDownHeaderItem("111"),
          GZXDropDownHeaderItem("22"),
          GZXDropDownHeaderItem("33"),
          GZXDropDownHeaderItem("44", iconData: Icons.filter_frames, iconSize: 18),
        ],    // GZXDropDownHeader对应第一父级Stack的key
        stackKey: _stackKey,    // controller用于控制menu的显示或隐藏
        controller: _dropdownMenuController,    // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
        onItemTap: (index) {      if (index == 3) {
          _scaffoldKey.currentState.openEndDrawer();
         // _dropdownMenuController.hide();
        }
        },    // 头部的高度
        height: 40,    // 头部背景颜色
        color: Colors.red,    // 头部边框宽度
        borderWidth: 1,    // 头部边框颜色
        borderColor: Color(0xFFeeede6),    // 分割线高度
        dividerHeight: 20,    // 分割线颜色
        dividerColor: Color(0xFFeeede6),    // 文字样式
        style: TextStyle(color: Color(0xFF666666), fontSize: 13),    // 下拉时文字样式
        dropDownStyle: TextStyle(
          fontSize: 13,
          color: Theme.of(context).primaryColor,
        ),    // 图标大小
        iconSize: 20,    // 图标颜色
        iconColor: Color(0xFFafada7),    // 下拉时图标颜色
        iconDropDownColor: Theme.of(context).primaryColor,
      ),
    );
/*    AuthorMainPageModel model = Provider.of(context);
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        var item = model.itemList[index];
        if (item.type == 'videoCollectionOfHorizontalScrollCard') {
          return CollectionCard(
            item: item,
            childIndex: index,
          );
        } else if (item.type == 'textHeader') {
          return Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              bottom: 10,
            ),
            child: Text(
              item.data.text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (item.type == 'textFooter') {
          return Container(
            color: Colors.white,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            child: Text(
              '${item.data.text} >',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          );
        } else if (item.type == 'video') {
          return VideoWelcomePage(
            item: item,
          );
        } else if (item.type == 'videoCollectionWithBrief') {
          return FollowItemDetailsWidget(
            item: item,
          );
        }
        return Text(item.type);
      },
      itemCount: model.itemList.length,
    );*/
  }
}
