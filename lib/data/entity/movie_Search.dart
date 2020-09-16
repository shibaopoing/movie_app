class MovieSearch{
  String _searchKey;
  int _curPageNum;
  int _id;
  String get searchKey => _searchKey;

  set searchKey(String value) {
    _searchKey = value;
  }

  int get curPageNum => _curPageNum;

  set curPageNum(int value) {
    _curPageNum = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  MovieSearch.empty();
  MovieSearch(this._searchKey, this._curPageNum,this._id);
  MovieSearch.fromJson(Map<String, dynamic> json)
      : _searchKey = json['searchKey'],
        _id = json['id'],
        _curPageNum = json['curPageNum'];
  Map<String, dynamic> toJson() => {
    'searchKey': _searchKey,
    'curPageNum': _curPageNum,
    'id': _id,
  };
}