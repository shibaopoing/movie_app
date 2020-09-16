import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;
  final int index;
  final callBack;
  final String description;
  const VideoWidget({Key key, @required this.url, @required this.play,@required this.index,this.description,this.callBack})
      : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}
class _VideoWidgetState extends State<VideoWidget> with WidgetsBindingObserver {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool activated=false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
/*    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }*/
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    int index = oldWidget.index;
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        activated=true;
        _controller.play();
        _controller.setLooping(true);
        if(widget.callBack!=null){
          widget.callBack(_controller);
        }
      } else {
        _controller.pause();
        activated=false;
      }
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("pageState: $state");
    if (state == AppLifecycleState.paused) {
      if (_controller.value.isPlaying) {
        _controller.pause();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          //color: Colors.white,
          height: 250,
          alignment: Alignment.center,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                   VideoPlayer(_controller),
                    _playPauseOverlay( _controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true,colors:VideoProgressColors(playedColor: Colors.white),),
                  ],
                );

              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(widget.description),
        )
      ]
    );
  }
  _playPauseOverlay(VideoPlayerController controller){
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying&&activated
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(activated){
              controller.value.isPlaying ? controller.pause() : controller.play();
              setState(() {

              });
            }
          },
        ),
      ],
    );
  }
}