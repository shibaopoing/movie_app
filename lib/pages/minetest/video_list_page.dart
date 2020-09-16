import 'dart:math';


import 'video_list_data.dart';
import 'video_list_widget.dart';
import 'package:flutter/material.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  final _random = new Random();
  final List<String> _videos = [
    "https://bobo.okokbo.com/20171220/ARVuPC7I/index.m3u8",
    "https://bobo.okokbo.com/20171220/ARVuPC7I/index.m3u8",
    //"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  ];
  List<VideoListData> dataList = List();

  @override
  void initState() {
    _setupData();
    super.initState();
  }

  void _setupData() {
    for (int index = 0; index < 10; index++) {
      var randomVideoUrl = _videos[_random.nextInt(_videos.length)];
      dataList.add(VideoListData("Video $index", randomVideoUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          VideoListData videoListData = dataList[index];
          return VideoListWidget(
            videoListData: videoListData,
          );
        },
      ),
    );
  }
}
