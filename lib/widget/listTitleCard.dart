import 'package:flutter/material.dart';
import 'package:movie_app/util/text_style.dart';
class ListTitleCard extends StatelessWidget {
  final List<Map> widgets;
  final String title;
  final double barHeight = 30.0;
  final double listWith ;
  final double listHeight;
  final Function callback;
  final List backColor;
  ListTitleCard(this.title,this.widgets,this.listWith,this.listHeight,this.backColor,this.callback);
  static int currentId = 0;
  List<int> selectedItem = new List();
  @override
  Widget build(BuildContext context) {


    return new Container(
      //margin:  new EdgeInsets.only(top:5),
      height: 100,
      color: Color.fromRGBO(this.backColor[0], this.backColor[1],this.backColor[2], 0.2),
      child: new Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(15,5,0,0),
                child:new Text(title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(right:10,top: 10),
                child:new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text("更多",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    new Icon(Icons.keyboard_arrow_right,color: Colors.white,size:15,),
                  ],
                )
              ),
            ],
          ),
         // new Separator(),
          new Container(
            margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
            height: 65,

            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:widgets==null?0:widgets.length,
              itemBuilder: (BuildContext context, int index){
                return _getData(context, index);
              }
            ),
          )
        ],
      ),
    );
  }
  Widget  _getData(BuildContext context, int position){
    if(widgets!=null){
      return GestureDetector(
        onTap: () {
          print(position);
          if(currentId==position){
            return;
          }
          if(!selectedItem.contains(currentId)){
            selectedItem.add(currentId);
          }
          if(selectedItem.contains(position)){
            selectedItem.remove(position);
          }
          //修改选中颜色
          for(int i=0;i<widgets.length;i++){
              if(selectedItem.contains(i)){
                widgets[i]['color'] = Color.fromRGBO(this.backColor[0], this.backColor[1],this.backColor[2],0.1);
                widgets[i]['playColor'] = Color.fromRGBO(this.backColor[0], this.backColor[1],this.backColor[2],0.1);
              }else{
                if(i==position){
                  widgets[i]['color'] = Color.fromRGBO(this.backColor[0], this.backColor[1],this.backColor[2],0.5);
                  widgets[i]['playColor'] = Color.fromRGBO(this.backColor[0], this.backColor[1],this.backColor[2],0.9);
                }
              }
          }
          currentId = position;
          this.callback(widgets[position]);
        },
        child:
        Center(
            child: new Container(
                width: listWith,
                height: listHeight,
                decoration: new BoxDecoration(
                  color:  widgets[position]['color'],
                  border: Border.all(
                      color: widgets[position]['playColor'],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(5),
                //padding: EdgeInsets.only(top: 2.0),
                child: Center(child: new Text(widgets[position]['title'],
                  style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),)))),
      );
    }else{
      return null;
    }
  }
}
