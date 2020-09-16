import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class MessageDialog extends Dialog {
  String title;
  String message;
  String negativeText;
  String positiveText;
  Function onCloseEvent;
  Function onPositivePressEvent;

  MessageDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        new Center(
                          child: new Text(
                            title,
                            style: new TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.pop(context); //关闭对话框
                            if (onCloseEvent != null) {
                              onCloseEvent();
                            }
                          },
                          child: new Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new Icon(
                              Icons.close,
                              color: Color(0xffe0e0e0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  new Container(
                    constraints: BoxConstraints(minHeight: 60.0),
                    child: new Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new IntrinsicHeight(
                        child: new Text(
                          message,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  this._buildBottomButtonGroup(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup(context) {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton(context));
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton(context));
    return new Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomCancelButton(context) {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: () {
          Navigator.pop(context); //关闭对话框
          if (onCloseEvent != null) {
            onCloseEvent();
          }
        },
        child: new Text(
          negativeText,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton(context) {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: () {
          Navigator.pop(context); //关闭对话框
          if (onPositivePressEvent != null) {
            onPositivePressEvent();
          }
        },
        child: new Text(
          positiveText,
          style: TextStyle(
            color: Color(Colors.teal.value),
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
