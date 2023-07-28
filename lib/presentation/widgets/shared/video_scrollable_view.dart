import 'package:flutter/material.dart';
import 'package:flutter_toktik/domain/entities/video_post.dart';
import 'package:flutter_toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:flutter_toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // Similar a v-windows
      scrollDirection: Axis.vertical, // Direccion de como pasar de ventana
      physics: const BouncingScrollPhysics(), // animacion
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];
        return Stack(
          children: [
            // video player + gradiente
            SizedBox.expand(
              child: FullScreenPlayer(videoUrl: videoPost.videoUrl, caption: videoPost.caption,),
            ),

            // Botones
            Positioned(
                bottom: 40, right: 20, child: VideoButtons(video: videoPost)),
          ],
        );
      },
    );
  }
}

/// Builder construye bajo demanda
