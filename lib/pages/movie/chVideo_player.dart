import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class ChVideoPlayer extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ChVideoPlayer({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);
  @override
  _ChVideoPlayer createState() => _ChVideoPlayer();
}
class _ChVideoPlayer extends State<ChVideoPlayer> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
      _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 5 / 3,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      autoPlay: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
  @override
  void dispose() {
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}