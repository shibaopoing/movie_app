import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/entity/rsp_obj.dart';
import 'package:movie_app/util/urlUtl.dart';

class DioUtil {
  static const String GET = "get";
  static const String POST = "post";
  static Dio _getDio = null;
  static Dio _postDio = null;
  static Response get(String url) {
    if (_getDio == null) {
      _getDio = new Dio(DioConfig.getDioOptions(GET, url));
    }
    Future<Response<String>> response = _getDio.get(url);
    response.then((Response response) async {
      return response;
    });
  }

  static Future post(String url, Map<String, dynamic> data, Function callBack,
      Function errorCallBack, BuildContext context) async {
    if (_postDio == null) {
      _postDio = new Dio(DioConfig.getDioOptions(POST, url));
    }
    Response response;
    try {
      response = await _postDio.post(url, data: data);
      if(context!=null){
        Navigator.pop(context);
      }
    } catch (exception) {
      if(context!=null){
        Navigator.pop(context);
      }
      RspObj rspObj = new RspObj(false, "", "无法连接服务器", null,null,null);
      _handError(errorCallBack, rspObj);
      return;
    }
    int statusCode = response.statusCode;
    //处理错误部分
    if (statusCode != 200) {
      RspObj rspObj = new RspObj(
          false, statusCode, response.data.toString(), response.data,statusCode,response.data.toString());
      _handError(errorCallBack, rspObj);
    } else {
      RspObj rspObj = RspObj.fromJson(response.data);
      if (rspObj.success) {
        if (callBack != null) {
          callBack(rspObj);
        }
      } else {
        _handError(errorCallBack, rspObj);
      }
    }
  }
  static Future<RspObj>  postAwait(String url, Map<String, dynamic> data)  async{
    if (_postDio == null) {
      _postDio = new Dio(DioConfig.getDioOptions(POST, url));
    }
    Response response;
    try {
      response = await _postDio.post(url, data: data);

    } catch (exception) {
      RspObj rspObj = new RspObj(false, "", "无法连接服务器", null,null,null);
      return rspObj;
    }
    int statusCode = response.statusCode;
    //处理错误部分
    if (statusCode != 200) {
      RspObj rspObj = new RspObj(
          false, statusCode, response.data.toString(), response.data,statusCode,response.data.toString());
      return rspObj;
    } else {
      RspObj rspObj = RspObj.fromJson(response.data);
      return rspObj;
    }
  }
  //处理异常
  static void _handError(Function errorCallback, RspObj rspObj) {
    if (errorCallback != null) {
      errorCallback(rspObj);
    }
  }
}

class DioConfig {
  static BaseOptions getDioOptions(String method, String url) {
    return new BaseOptions(
        method: method,
        baseUrl: Url.BaseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
        followRedirects: true,
        contentType:"application/json");
  }
}
