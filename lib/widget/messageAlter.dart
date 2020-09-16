import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Alter {
  static Future show(BuildContext context, String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
      backgroundColor: Colors.black38,
    );
  }
}
