class ShortVideo {
  String _title="";
  String _imgUrl="";
  String _playUrl="";
  int _id=0;
  String _score="";
  String _casts="";
  String _year="";
  String _genres="";
  /// 是否需要vip才能观看
  bool _needVip=false;
  /// 播放量
  int _playsCount=0;
  List _backColors;
  ShortVideo.empty();
  ShortVideo.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as num,
        _title = json['title'],
        _imgUrl = json['imgUrl'],
        _playUrl = json['playUrl'],
        _score = json['score'],
        _casts = json['casts'],
        _year = json['year'],
        _backColors = json['backColors'],
        _genres = json['genres'];
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['playUrl'] = this.playUrl;
    data['score'] = this.score;
    data['casts'] = this.casts;
    data['year'] = this.year;
    data['backColors'] = this.backColors;
    data['genres'] = this.genres;
    return data;
  }
  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get imgUrl => _imgUrl;


  set imgUrl(String value) {
    _imgUrl = value;
  }

  String get genres => _genres;

  set genres(String value) {
    _genres = value;
  }

  String get year => _year;

  set year(String value) {
    _year = value;
  }

  String get casts => _casts;

  set casts(String value) {
    _casts = value;
  }

  String get score => _score;

  set score(String value) {
    _score = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get playUrl => _playUrl;

  set playUrl(String value) {
    _playUrl = value;
  }

  int get playsCount => _playsCount;

  set playsCount(int value) {
    _playsCount = value;
  }

  bool get needVip => _needVip;

  set needVip(bool value) {
    _needVip = value;
  }

  List get backColors => _backColors;

  set backColors(List value) {
    _backColors = value;
  }

}