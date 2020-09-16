import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:movie_app/data/entity/movie_Info.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/router/router_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:movie_app/data/entity/category_entity.dart';
import 'package:movie_app/pages/discovery/category/category_list_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/util/fluro_convert_util.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:movie_app/widget/search/search_bar.dart' as search_bar;
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import 'package:movie_app/widget/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'category_list_item.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

import 'sortConditon.dart';
/// 分类列表
class CategoryListPage extends StatefulWidget {
 // final String itemJson;

//  CategoryListPage({Key key, this.itemJson}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _dropDownHeaderItemStrings = ['区域', '年代', '明星', '刷新'];
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();

  SortCondition _selectBrandSortCondition;

  SortCondition _selectDistanceSortCondition;
  GlobalKey _stackKey = GlobalKey();
  int area;
  int year;
  int actors;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //Map item = (FluroConvertUtils.string2map(widget.itemJson));
   // int type = item['type'];
    return ProviderWidget<CategoryListModel>(
      model: CategoryListModel(1),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white, //Changing this will change the color of the TabBar
          ),
          home: Scaffold(
              key: _scaffoldKey,
              appBar:AppBar(
                title: Text('分类'),
                centerTitle: true,
                backgroundColor: Colors.white,
                /// 去除阴影
                elevation: 0,
/*                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios), //自定义图标
                    onPressed: () {
                      RouterManager.router.pop(context);
                    },
                ),*/
                actions: <Widget>[
                  IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 0.0),
                    icon: Icon(
                      Icons.search,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      search_bar.showSearch(
                        context: context,
                        delegate: SearchBarDelegate(),
                      );
                    },
                  ),
                ],
              ),
            body: Stack(
              key: _stackKey,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      subCategoryBar(model),
                      Expanded(
                          child: Container(
                            // color: Colors.white,
                            child: VerticalTabs(
                              tabsWidth: 60,
                              selectedTabBackgroundColor: Colors.white,
                              tabBackgroundColor: Colors.black26,
                              backgroundColor: Colors.white,
                              tabsShadowColor: Colors.white,
                              //direction: TextDirection.ltr,
                              // contentScrollAxis: Axis.vertical,
                              //changePageDuration: Duration(milliseconds: 500),
                              tabs: tabs(model),
                              onSelect:(index) {
                                model.setSelectedCurrentCategory(index) ;
                                this.area = null;
                                this.year = null;
                                this.actors= null;
                                //setState(() {});
                              },
                              contents:contents(model),
                            ),
                          )
                      )
                    ],
                  ),
                  GZXDropDownMenu(
                    // controller用于控制menu的显示或隐藏
                    controller: _dropdownMenuController,
                    // 下拉菜单显示或隐藏动画时长
                    animationMilliseconds: 300,
                    // 下拉后遮罩颜色
//          maskColor: Theme.of(context).primaryColor.withOpacity(0.5),

          //maskColor: Colors.red.withOpacity(0.5),

                    // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
                    menus: [
                      GZXDropdownMenuBuilder(
                          dropDownHeight: 50*(((4-model.areas.length%4)+model.areas.length)/4),
                          dropDownWidget: _buildConditionListWidget(model.areas, (value){

 /*                           _dropDownHeaderItemStrings[0] = selectValue;
                            _dropDownHeaderItemStrings[0] =
                            _selectBrandSortCondition.name == '全部' ? '品牌' : _selectBrandSortCondition.name;
                            _dropdownMenuController.hide();*/

                            setState(() {});

                          })),

                      GZXDropdownMenuBuilder(

                          dropDownHeight: 50*(((4-model.years.length%4)+model.years.length)/4),

                          dropDownWidget: _buildConditionListWidget(model.years, (value) {
/*
                            _selectBrandSortCondition = value;

                            _dropDownHeaderItemStrings[1] =

                            _selectBrandSortCondition.name == '全部' ? '品牌' : _selectBrandSortCondition.name;

                            _dropdownMenuController.hide();*/

                            setState(() {});

                          })),

                      GZXDropdownMenuBuilder(

                          dropDownHeight: 50*(((4-model.actors.length%4)+model.actors.length)/4),

                          dropDownWidget: _buildConditionListWidget(model.actors, (value) {

/*                            _selectDistanceSortCondition = value;

                            _dropDownHeaderItemStrings[2] = _selectDistanceSortCondition.name;

                            _dropdownMenuController.hide();*/

                            setState(() {});

                          })),
                    ],
                  ),
                ]
              )
          ),
        );
      }
    );
  }
  Widget tabsBarItem(String name, [ String description = '' ] ) {
    return Tab(
      child: Container(
          height: 30,
          //margin: EdgeInsets.only(bottom: 1),
          child:Center(
            child: Text(name,textAlign:TextAlign.justify),
        )
      ),
    );
  }
  List<Tab> tabs(CategoryListModel model) {
    List tabItems = model.categoryList;
    List fe = List<Tab>.generate(tabItems.length, (int index){ // 也是可变数组
      return tabsBarItem(tabItems[index].name);
    });
    return fe;
  }
  List<Widget> contents(CategoryListModel model) {
    List tabItems = model.categoryList;
    List fe = List<Widget>.generate(tabItems.length, (int index){ // 也是可变数组
      tabItems[index].id=index;
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10),
        child: RefreshConfiguration(
          enableLoadingWhenNoData: false,
          child: SmartRefresher(
            header: WaterDropHeader(),
            footer: refresh.CustomFooter(
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
                  body = Text("No more Data");
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
              child: CategoryListWidget(model:model,id:index,parent: context),
            ),
          ),
        ),
      );
    });
    return fe;
  }
  List<DropdownMenuItem> buildDropdownMenuItem(List list){
    List<DropdownMenuItem> items = List<DropdownMenuItem>.generate(list.length, (int index){ // 也是可变数组
      return DropdownMenuItem(
        child:Text(list[index],style: TextStyle(fontSize: 12)),
        value: index
      );
    });
    return items;
  }
  Widget subCategoryBar(CategoryListModel model) {
/*    const Color delColor = Colors.red;
    GZXDropDownHeaderItem item = new GZXDropDownHeaderItem("sppIng");
    GZXDropDownHeaderItem item1 = new GZXDropDownHeaderItem("hhh");
    List<GZXDropDownHeaderItem> items = new List();
    items.add(item);
    items.add(item1);
    GZXDropdownMenuController controller  =new GZXDropdownMenuController();
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      height: 30,
      child:Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RawChip(
              padding: EdgeInsets.only(bottom: 14),
              deleteIconColor:delColor,
              label: DropdownButton(
                  icon:Icon(Icons.arrow_drop_down,size: 1,) ,
                  value: area,
                  hint: Text('地区',style: TextStyle(fontSize: 12)),
                  items: buildDropdownMenuItem(model.areas),
                  onChanged: (value) => setState(() => area = value)
                  ),
              onDeleted: (){
                setState(() => area = null);
              },
            ),
            RawChip(
              padding: EdgeInsets.only(bottom: 10),
              deleteIconColor:delColor,
              label: DropdownButton(
                  icon:Icon(Icons.arrow_drop_down,size: 1,) ,
                  value: year,
                  hint: Text('年代',style: TextStyle(fontSize: 12)),
                  items: buildDropdownMenuItem(model.years),
                  onChanged: (value) => setState(() => year = value)),
              onDeleted: (){
                setState(() => year = null);
              },
            ),
            RawChip(
              padding: EdgeInsets.only(bottom: 10),
              deleteIconColor:delColor,
              label: DropdownButton(
                  icon:Icon(Icons.arrow_drop_down,size: 1,) ,
                  value: actors,
                  hint: Text('明星',style: TextStyle(fontSize: 12)),
                  items: buildDropdownMenuItem(model.actors),
                  onChanged: (value) => setState(() => actors = value)),
              onDeleted: (){
                setState(() => actors = null);
              },
            ),
          ],
        ),
      ),
    );*/
    return GZXDropDownHeader(
      // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
      items: [
        GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0]),
        GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1]),
        GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2]),
        GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3], iconData: Icons.clear, iconSize: 15),
      ],

      // GZXDropDownHeader对应第一父级Stack的key

      stackKey: _stackKey,

      // controller用于控制menu的显示或隐藏

      controller: _dropdownMenuController,

      // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer

      onItemTap: (index) {

        if (index == 3) {

          _dropdownMenuController.hide();

          _scaffoldKey.currentState.openEndDrawer();

        }

      },

//                // 头部的高度

//                height: 40,

//                // 头部背景颜色

                //color: Colors.red,

//                // 头部边框宽度

//                borderWidth: 1,

//                // 头部边框颜色

                //borderColor: Color(0xFFeeede6),

//                // 分割线高度

//                dividerHeight: 20,

//                // 分割线颜色

                //dividerColor: Color(0xFFeeede6),

//                // 文字样式

//                style: TextStyle(color: Color(0xFF666666), fontSize: 13),

//                // 下拉时文字样式

                dropDownStyle: TextStyle(

                  fontSize: 13,

                  color: Colors.red,

                ),

//                // 图标大小

//                iconSize: 20,

//                // 图标颜色

//                iconColor: Color(0xFFafada7),

//                // 下拉时图标颜色

//                iconDropDownColor: Theme.of(context).primaryColor,

    );
  }
  _buildConditionListWidget(items, void itemOnTap(SortCondition sortCondition)) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:10),
          child:GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            // item 的个数
            // 添加分割线
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 1,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
             SortCondition goodsSortCondition = items[index];
              return FilterChip(
                //key:items[index].id,
                label:Text(items[index].name,style: TextStyle(fontSize: 12),),
                selected: items[index].isSelected,
                onSelected: (bool value){
                  if(items[index].isSelected){
                    items[index].isSelected=false;
                  }else{
                    items[index].isSelected=true;
                  }
                  setState(() {
                  });
                  print("选择了"+items[index].name);
                },
              );
            },
          ),
        ),
/*        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ButtonBar(
            alignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(child: Text('确定'),),
              RaisedButton(child: Text('重置'),)
            ],
          ),
        )*/
      ],
    ) ;

  }
}
class CategoryListWidget extends StatelessWidget {
  final CategoryListModel model;
  final int  id;
  final BuildContext parent;
  CategoryListWidget({Key key, @required this.model,this.id,this.parent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(id ==null){
      return LoadingWidget();
    }
    if(model.movieList==null||model.movieList.length==0){
      return LoadingWidget();
    }
    if(model.movieList[id]==null||model.movieList[id].length==0){
      return LoadingWidget();
    }
    return GridView.builder(
      itemCount:model.movieList[id].length,
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
        return CategoryItem(item: model.movieList[id][index],parent: this.parent,);
      },
    );
    //CategoryListModel model = Provider.of(context);
  }
}