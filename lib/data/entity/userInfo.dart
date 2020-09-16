class UserInfo {
  num _id;
  String _userCode;
  String _userName;
  String _userPwd;
  String _userPhone;
  String _userEmail;
  String _faceImage;
  String _faceImageBig;
  UserInfo.empty();
  UserInfo(this._id, this._userCode, this._userName, this._userPwd,
      this._userPhone, this._userEmail, this._faceImage, this._faceImageBig);

  UserInfo.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as num,
        _userName = json['userName'],
        _userCode = json['userCode'],
        _userPwd = json['userPwd'],
        _userPhone = json['userPhone'],
        _userEmail = json['userEmail'],
        _faceImage = json['faceImage'],
        _faceImageBig = json['faceImageBig'];
  Map<String, dynamic> toJson() => {
        'id': _id,
        'userName': _userName,
        'userCode': _userCode,
        'userPwd': _userPwd,
        'userPhone': _userPhone,
        'userEmail': _userEmail,
        'faceImage': _faceImage,
        'faceImageBig': _faceImageBig,
      };

  String get faceImageBig => _faceImageBig;

  set faceImageBig(String value) {
    _faceImageBig = value;
  }

  String get faceImage => _faceImage;

  set faceImage(String value) {
    _faceImage = value;
  }

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get userPhone => _userPhone;

  set userPhone(String value) {
    _userPhone = value;
  }

  String get userPwd => _userPwd;

  set userPwd(String value) {
    _userPwd = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userCode => _userCode;

  set userCode(String value) {
    _userCode = value;
  }

  num get id => _id;

  set id(num value) {
    _id = value;
  }
}
