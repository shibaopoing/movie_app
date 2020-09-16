import 'package:flutter/widgets.dart';

class ShareDataWidget extends InheritedWidget {
  String data; //需要在子树中共享的数据
  final Function callback;
  ShareDataWidget(
      {Key key,
      @required this.data,
      @required this.callback,
      @required Widget child})
      : super(key: key, child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    //return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.dependOnInheritedWidgetOfExactType();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return data != old.data;
  }
}
