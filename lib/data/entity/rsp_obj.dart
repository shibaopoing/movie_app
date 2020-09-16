
import 'base_rsp.dart';

class RspObj extends BaseRsp<Map> {
  String rspCode;
  String rspMsg;
  RspObj(success, code, message, data,rspCode,rspMsg) : super(success, code, message, data);
  getBlockHash() {
    return data;
  }

  factory RspObj.fromJson(Map<String, dynamic> json) {
    String retCode = json['rspCode'];
    String retMsg = json['rspMsg'];
    String code = json['code'];
    String message = json['message'];
    bool success = json['success'];
    if(null!=retCode){
      code=retCode;
      message = retMsg;
      if("0000"==retCode){
        success=true;
      }else{
        success=false;
      }
    }
    return RspObj(
        success, code, message, json['data'],retCode,retMsg);
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'success': this.success,
    'code': this.code,
    'message': this.message,
    'data': this.data,
    'rspCode': this.success,
    'rspMsg': this.code
  };
}
