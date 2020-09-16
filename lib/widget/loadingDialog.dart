import 'package:flutter/material.dart';
import 'package:movie_app/util/dioUtil.dart';

// ignore: must_be_immutable
class LoadingDialog extends StatefulWidget {
  String loadingText;
  bool outsideDismiss;
  String url;
  String method;
  Map<String, dynamic> params;
  Function callBack;
  Function errorCallBack;
  Function dismissCallback;
  BuildContext context;
  LoadingDialog(
      {Key key,
      this.loadingText = "loading...",
      this.outsideDismiss = true,
      this.url,
      this.method,
      this.params,
      this.callBack,
      this.errorCallBack,
      this.dismissCallback,
      this.context})
      : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialog();
}

class _LoadingDialog extends State<LoadingDialog> {
  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(widget.context).pop();
  }

  @override
  void initState() {
    super.initState();
    DioUtil.post(widget.url, widget.params, widget.callBack,
            widget.errorCallBack, widget.context)
        .then((_) {
      // Navigator.of(_globalKey.currentContext).pop(); 当返回信息被其他context处理后，此段代码失效
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      key: _globalKey,
      onTap: widget.outsideDismiss ? _dismissDialog : null,
      child: Material(
        type: MaterialType.transparency,
        child: new Center(
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      widget.loadingText,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
