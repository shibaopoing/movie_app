class Video{
  List<Item> itemList;
  int total;
  int index;
  int publishTime;
  int releaseTime;
  String type;
  Video(
      {this.total,
        this.publishTime,
        this.releaseTime,
        this.index,
        this.itemList,
        this.type});
  Video.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    publishTime = json['publishTime'];
    releaseTime = json['releaseTime'];
    index = json['index'];
    if (json['rows'] != null) {
      itemList = new List<Item>();
      (json['rows'] as List).forEach((v) {
        itemList.add(new Item.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['publishTime'] = this.publishTime;
    data['releaseTime'] = this.releaseTime;
    data['count'] = this.index;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Item {
    String title="";
    String imgUrl="";
    List playUrls;
    int id=0;
    String score="";
    String casts="";
    String year="";
    String genres="";
    /// 是否需要vip才能观看
    bool needVip=false;
    /// 播放量
    int playsCount=0;
    List backColors;
    String category;
    String createTime;
Item.fromJson(Map<String, dynamic> json)
    : id = json['id'] as num,
    title = json['title'],
    imgUrl = json['imgUrl'],
    playUrls = json['playUrls'],
    score = json['score'],
    casts = json['casts'],
    year = json['year'],
      backColors = json['backColors'],
    category= json['contentType'],
    createTime= json['createTime'],
    genres = json['genres'];
  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['title'] = this.title;
      data['imgUrl'] = this.imgUrl;
      data['playUrls'] = this.playUrls;
      data['score'] = this.score;
      data['casts'] = this.casts;
      data['year'] = this.year;
      data['backColors'] = this.backColors;
      data['category'] = this.category;
      data['createTime'] = this.createTime;
      data['genres'] = this.genres;
      return data;
  }
}