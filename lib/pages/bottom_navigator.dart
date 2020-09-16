
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/discovery/category/category_list_page.dart';
import 'package:movie_app/pages/minetest/my_test2.dart';
import 'package:movie_app/pages/shortVideo/video_list_page.dart';

import 'discovery/discovery_page.dart';
import 'home/home_page.dart';
import 'hot/hot_page.dart';
import 'mine/mine_page.dart';
import 'movie/movie_page.dart';
import 'rank/rank_page.dart';

class BottomNavigator extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => BottomNavigatorState();

}

class BottomNavigatorState extends State<BottomNavigator>{

  // 记录当前 tab 选择位置
  int tabIndex = 0;
  var tabImages;
  var tabPages;

  final tabTextStyleNormal = TextStyle(color: Colors.black38);
  final tabTextStyleSelected = TextStyle(color: Colors.black);
  final tabTitles = <String>['首页', '短视频','分类','排行', '我的'];
  //ValueNotifier<int> currentIndex = ValueNotifier(tabIndex);
  var body;

  @override
  void initState() {
    super.initState();
    tabImages ??= [
      [
        getTabImage('images/ic_home_normal.png'),
        getTabImage('images/ic_home_selected.png')
      ],
      [
        getTabImage('images/ic_discovery_normal.png'),
        getTabImage('images/ic_discovery_selected.png')
      ],
      [
        getTabImage('images/ic_discovery_normal.png'),
        getTabImage('images/ic_discovery_selected.png')
      ],
      [
        getTabImage('images/ic_hot_normal.png'),
        getTabImage('images/ic_hot_selected.png')
      ],
      [
        getTabImage('images/ic_mine_normal.png'),
        getTabImage('images/ic_mine_selected.png')
      ],
    ];
   // tabPages ??= [DiscoveryPage(),new InheritedState(data: tabIndex,child: VideoListPage(),)  ,CategoryListPage(), RankPage(),MinePage()];
  }

  Image getTabImage(imagePath) => Image.asset(imagePath, width: 22, height: 22);

  Image getTabIcon(int index) {
    if (tabIndex == index) {
      return tabImages[index][1];
    }
    return tabImages[index][0];
  }

  TextStyle getTabTextStyle(int index) {
    if (tabIndex == index) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(index) => Text(
    tabTitles[index],
    style: getTabTextStyle(index),
  );
  @override
  Widget build(BuildContext context) {
    body = IndexedStack(
      children: [
        DiscoveryPage(),
        InheritedState(data: tabIndex,child: VideoListPage(),),
        CategoryListPage(),
        RankPage(),
        MinePage(),
       // MinePage()
      ],
      index: tabIndex,
    );
    return Scaffold(
      body: this.body,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Color(0xFFFFFFFF),
        items: [
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
          BottomNavigationBarItem(icon: getTabIcon(4), title: getTabTitle(4)),
        ],
        currentIndex: tabIndex,
        onTap: (index) => {
          setState(() {
            tabIndex = index;
          })
        },
      ),
    );
  }
}
class InheritedState extends InheritedWidget {
  final  int data;

  //我们知道InheritedWidget总是包裹的一层，所以它必有child
  InheritedState(
      {Key key, @required this.data, @required Widget child})
      : super(key: key, child: child);
  //定义一个便捷方法，方便子树中的widget获取共享数据
  static InheritedState of(BuildContext context) {
    //return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.dependOnInheritedWidgetOfExactType<InheritedState>();
  }
  //参考MediaQuery,这个方法通常都是这样实现的。如果新的值和旧的值不相等，就需要notify
  @override
  bool updateShouldNotify(InheritedState oldWidget) =>
      data != oldWidget.data;
}