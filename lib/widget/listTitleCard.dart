import 'package:flutter/material.dart';
import 'package:movie_app/util/text_style.dart';
class ListTitleCard extends StatefulWidget {
  final List<Map> members;
  final String title;
  final double barHeight = 30.0;
  final double listWith ;
  final double listHeight;
  final Function callback;
  final List backColor;
  ListTitleCard({Key key,this.title,this.members,this.listWith,this.listHeight,this.backColor,this.callback}): super(key: key);
  @override
  _ListTitleCardState createState() => _ListTitleCardState();
}
class _ListTitleCardState extends State<ListTitleCard> {
  static int currentId = 0;
  List<int> selectedItem = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      //margin:  new EdgeInsets.only(top:5),
      height: 100,
      color: Color.fromRGBO(widget.backColor[0], widget.backColor[1],widget.backColor[2], 0.2),
      child: new Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(15,5,0,0),
                child:new Text(widget.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    decoration: TextDecoration.none
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
                        decoration: TextDecoration.none
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
              itemCount:widget.members==null?0:widget.members.length,
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
    if(widget.members!=null){
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
          for(int i=0;i<widget.members.length;i++){
              if(selectedItem.contains(i)){
                widget.members[i]['color'] = Color.fromRGBO(widget.backColor[0], widget.backColor[1],widget.backColor[2],0.1);
                widget.members[i]['playColor'] = Color.fromRGBO(widget.backColor[0], widget.backColor[1],widget.backColor[2],0.1);
              }else{
                if(i==position){
                  widget.members[i]['color'] = Color.fromRGBO(widget.backColor[0], widget.backColor[1],widget.backColor[2],0.5);
                  widget.members[i]['playColor'] = Color.fromRGBO(widget.backColor[0], widget.backColor[1],widget.backColor[2],0.9);
                }
              }
          }
          setState(() {
            currentId = position;
          });
          widget.callback(widget.members[position]);
        },
        child:
        Center(
            child: new Container(
                width: widget.listWith,
                height: widget.listHeight,
                decoration: new BoxDecoration(
                  color:  widget.members[position]['color'],
                  border: Border.all(
                      color: widget.members[position]['playColor'],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(5),
                //padding: EdgeInsets.only(top: 2.0),
                child: Center(child: new Text(widget.members[position]['title'],
                  style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  decoration: TextDecoration.none
                ),)))),
      );
    }else{
      return null;
    }
  }
}
