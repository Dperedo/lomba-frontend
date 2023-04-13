import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:video_player/video_player.dart';

import '../../domain/entities/workflow/imagecontent.dart';
import '../../domain/entities/workflow/textcontent.dart';
import '../../domain/entities/workflow/videocontent.dart';
import 'show_video_player.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class ShowPosts extends StatelessWidget {
  const ShowPosts(
      {super.key, required this.post, required this.child});
  final Post post;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                        post.title),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: post
                                    .postitems.length,
                    itemBuilder: (context, i) {
                    if (post.postitems[i].type=='text'){
                      return ListTile(
                        shape:
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            2))),
                        title: Text(
                            (post
                                .postitems[i].content
                                    as TextContent).text,
                          textAlign: TextAlign.center),
                        contentPadding:
                            const EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 100),
                      );
                    }
                    else if(post.postitems[i].type=='image'){
                      
                      final imagen = post
                            .postitems[i].content as ImageContent;
                      return Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )
                        ),
                        child: ImageNetwork(
                          image: imagen.url,
                          height: double.parse((imagen.height).toString()),
                          width: double.parse((imagen.width).toString()),
                        )
                      );
                    }
                    else if(post.postitems[i].type=='video'){
                      
                      final video = post
                            .postitems[i].content as VideoContent;
                      return Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          )
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ShowVideoPlayer(videoUrl: video.url,)
                        ),
                      );
                    }
                      else {return null;}
                    }
                  ),
                  const SizedBox(height: 10),
                  child ?? const SizedBox(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
        // const Divider()
      ],
    );
  }

  VideoPlayer showVideoPlayer(String videoUrl) {
  late VideoPlayerController _videoPlayerController;
    _videoPlayerController = VideoPlayerController.network(videoUrl);

    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
    });
    return VideoPlayer(
      _videoPlayerController,
    );
  }
}
