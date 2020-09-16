class StringUtil {
  static List<String> matchImageSrc(String srcImageStr) {
    List<String> result = [];
    RegExp exp = new RegExp(r"<(img|IMG)(.*?)(/>|></img>|>)");
    for (var item in exp.allMatches(srcImageStr)) {
      String str_img = item.group(2);
      print('str_img == $str_img');
      RegExp p_src = new RegExp(r"""(src|SRC)=(\"|\')(.*?)(\"|\')""");
      if (str_img != null && str_img.isNotEmpty) {
        var match = p_src.firstMatch(str_img);
        if (match != null) {
          result.add(match.group(3));
        }
      }
    }
    return result;
  }

  static String getSrcImagePath(String srcImageStr) {
    List list = matchImageSrc(srcImageStr);
    String path = list?.first;

    print('src === $path');
    return path;
  }

  static bool isPhoneNum(String phoneNum) {
    if (phoneNum.isEmpty) {
      return false;
    }
    var pheoneReg = RegExp(
        r"^(?:\+?86)?1(?:3\d{3}|5[^4\D]\d{2}|8\d{3}|7(?:[35678]\d{2}|4(?:0\d|1[0-2]|9\d))|9[189]\d{2}|66\d{2})\d{6}$");
    if (!pheoneReg.hasMatch(phoneNum)) {
      return false;
    }
    return true;
  }
}
