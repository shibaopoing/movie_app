import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/provider/home_page_model.dart';
import 'package:movie_app/provider/provider_widget.dart';
import 'package:movie_app/widget/search/search_bar.dart' as search_bar;
import 'package:provider/provider.dart';
///搜索控件widget
class CategorySearchFrame extends StatelessWidget {
  final text;
  CategorySearchFrame(this.text);
  Widget buildTextField(BuildContext context) {
    //theme设置局部主题
    return TextField(
      controller:TextEditingController(text:text),
     // cursorColor: Colors.black,
      decoration: InputDecoration(
        //输入框decoration属性
          border: InputBorder.none,
//            icon: Icon(Icons.search),
//            icon: ImageIcon(AssetImage("image/search_meeting_icon.png",),),
/*          icon: ImageIcon(
            AssetImage(
              "image/search.png",
            ),
          ),*/
          prefixIcon: IconButton(
            alignment:Alignment.centerLeft,
            padding : const EdgeInsets.all(8.0),
            color: Colors.black,
            iconSize: 15,
            icon: Icon(Icons.search),
            onPressed: () {

            }),
          hintText: "搜你所想",
          hintStyle: new TextStyle(fontSize: 14, color: Colors.black)),
      style: new TextStyle(fontSize: 14, color: Colors.black),
      maxLines: 1,
      autocorrect: true,
      autofocus: false,
      textAlign:TextAlign.left,
      enabled: true,
      readOnly: true,
      onChanged: (text) {
        //_model.setSearchKey(text);
      },
      onTap: (){
        search_bar.showSearch(
          context: context,
          delegate: SearchBarDelegate(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget editView() {
      return Container(
        //修饰黑色背景与圆角
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0), //灰色的一层边框
          //color: Colors.grey,
          borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
        ),
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: buildTextField(context),
      );
    }
    return ProviderWidget<HomePageModel>(
        model: HomePageModel(),
        onModelInitial: (model) {
          model.init();
        },
        builder: (context, model, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: editView(),
                flex: 1,
              ),
/*          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
            ),
           // child: cancleView,
          )*/
            ],
          );
        }
    );
  }
}