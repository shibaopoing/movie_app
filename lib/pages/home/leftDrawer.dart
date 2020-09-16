import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("自定义样式"),
                    //child按钮中的内容
                    textColor: Colors.white,
                    //文字颜色
                    disabledTextColor: Colors.red,
                    //按钮禁用时的文字颜色
                    color: Colors.lightBlue,
                    //背景颜色
                    disabledColor: Colors.grey,
                    //按钮禁用时的背景颜色
                    highlightColor: Colors.amber,
                    //按钮按下时的背景颜色
                    splashColor: Colors.black12,
                    //点击时，水波动画中水波的颜色
                    padding: EdgeInsets.all(2.0),
                    //内边距
                    colorBrightness: Brightness.dark,
                    ////按钮主题，默认是浅色主题
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    //外形
                    onPressed:(){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
