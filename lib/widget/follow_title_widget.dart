import 'package:flutter/material.dart';

class FollowTitleWidget extends StatelessWidget {
  final String title;
  final Function callback;
  final bool more;
  FollowTitleWidget(
      {Key key,@required this.title,@required this.callback,this.more})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Row(
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      more?'更多 >>':"",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      /// 跳转热门关注列表页
                      if(more){
                        if(this.callback!=null){
                          this.callback();
                        }
                      }
/*                      RouterManager.router.navigateTo(
                        context,
                        RouterManager.follow,
                        transition: TransitionType.inFromRight,
                      );*/
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/icon_no_data.png',
            width: 35,
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              '暂无搜索数据',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
