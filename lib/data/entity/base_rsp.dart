class BaseRsp<T> {
  BaseRsp(this.success, this.code, this.message, this.data);
  bool success;
  String code;
  String message;
  T data;
  Error err;
}

class Err {
  Err(this.code, this.message, this.data);
  String code;
  String message;
  String data;

  factory Err.fromJson(Map<String, dynamic> json) {
    return Err(json['code'] as String, json['message'] as String,
        json['data'] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'code': this.code,
    'message': this.message,
    'data': this.data
  };
}
