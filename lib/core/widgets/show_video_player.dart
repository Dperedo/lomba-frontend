import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ShowVideoPlayer({ Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ShowVideoPlayerState createState() => _ShowVideoPlayerState();
}

class _ShowVideoPlayerState extends State<ShowVideoPlayer> {
  late VideoPlayerController _controller;

  void _playVideo({bool init = false}) {

    if (!init) {
      _controller.pause();
    }

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => null);//_controller.play());
  }

  @override
  void initState() {
    super.initState();
    _playVideo(init: true);
    
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _controller.value.isInitialized ?
        Stack(
          children: [
            SizedBox(
              height: 240,
              child: VideoPlayer(_controller),
            ),
            Center(
              child: IconButton(
                onPressed: () => _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play(),
                icon: Icon(
                  _controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow
                )
              ),
            )
          ],
        ): const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
