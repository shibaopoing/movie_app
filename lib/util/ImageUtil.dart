import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageUtil {
  final ImagePicker _picker = ImagePicker();
   Future pickerImage() async {
    return await _picker.getImage(source: ImageSource.camera);
  }

   Future getImageFromMyGallery() async {
    return await _picker.getImage(source: ImageSource.gallery);
  }

  static Future cropImage(String filePth) async {
    var image = await ImageCropper.cropImage(
      sourcePath: filePth,
      maxWidth: 512,
      maxHeight: 512,
    );
    return image;
  }

  static Future<String> saveImage(String url, String name) async {
    final Uri resolved = Uri.base.resolve(url);
    http.Response response = await http.get(resolved);
    if (response.statusCode != HttpStatus.ok)
      throw Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}, $resolved');
    final Uint8List bytes = await response.bodyBytes;
    name = md5.convert(convert.utf8.encode(name)).toString();
    Directory dir = await getTemporaryDirectory();
    String path = dir.path + "/" + name;
    var file = File(path);
    bool exist = await file.exists();
    print("path =${path}");
    if (!exist) File(path).writeAsBytesSync(bytes);
    return path;
  }

  static Future<String> getImagePathFromSd(String name) async {
    if (name.toUpperCase().endsWith("JPG") ||
        name.toUpperCase().endsWith("PNG")) {
      return name;
    } else {
      name = md5.convert(convert.utf8.encode(name)).toString();
      Directory dir = await getTemporaryDirectory();
      return dir.path + "/" + name;
    }
  }

  static Future<Uint8List> getFromSdcard(String name) async {
    String path = await getImagePathFromSd(name);
    var file = File(path);
    bool exist = await file.exists();
    if (exist) {
      final Uint8List bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  static Future<Uint8List> loadDataFromUrl(String imageUrl) async {
    final Uri resolved = Uri.base.resolve(imageUrl);
    http.Response response = await http.get(resolved);
    if (response.statusCode != HttpStatus.ok)
      throw Exception(
          'HTTP request failed, statusCode: ${response?.statusCode}, $resolved');
    final Uint8List bytes = await response.bodyBytes;
    var file = Image.memory(bytes);
    return bytes;
  }

  static Future<Uint8List> loadAsync(String url) async {
    Uint8List bytes = await ImageUtil.getFromSdcard(url);
    if (bytes != null &&
        bytes.lengthInBytes != null &&
        bytes.lengthInBytes != 0) {
      return bytes;
    }
    return await loadDataFromUrl(url);
  }

  static Future<List> loadImagsFromUrl(String imageUrl) async {
    //String dataURL =Api.ImageUrl+LoginInfo.faceImageBig;
    List widgets = [];
    String dataURL =
        "https://sg.mangatoon.mobi/api/cartoons/pictures?sign=13d6205ff123cd8ffacc9c5e5f4f0b5a&id=3905&_=1546155223&_language=en&_udid=dcd28ecf49b45486cf6b2b743371d500&callback=jsonp_2";
    http.Response response = await http.get(dataURL);

    /*
    setState(() {
      String result = response.body;
      result = result.substring(result.indexOf("(")+1,result.length-1);
      // load = true;
/*      widgets = new List(1);
      widgets[0] = "";*/
      widgets = json.decode(result)["data"];
      widgets.forEach((d){
        String url = d["url"];
        d["url"]=url.substring(0,url.indexOf("encrypted"))+"watermark/"+ url.substring(url.lastIndexOf("/"),url.length-4)+"jpg";
      });
      for(int i=0;i<100;i++){
        widgets.add(widgets[i%10]);
      }
      print(widgets);
    });*/
  }
}
