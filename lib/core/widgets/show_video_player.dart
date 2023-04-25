import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ShowVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  ShowVideoPlayerState createState() => ShowVideoPlayerState();
}

class ShowVideoPlayerState extends State<ShowVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController? _chewieController;
  //bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => null);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showOptions: false,
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Chewie(
                controller: _chewieController!,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
      
  }
}
