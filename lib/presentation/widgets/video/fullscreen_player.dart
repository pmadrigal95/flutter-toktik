import 'package:flutter/material.dart';
import 'package:flutter_toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;

  final String caption;

  const FullScreenPlayer(
      {super.key, required this.videoUrl, this.caption = ''});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState(); // Ciclo de vida del StatefulWidget

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0) // bajar el volumen
      ..setLooping(true) // reiniciar el video automaticamente
      ..play(); // reproducir el video
  }

  @override
  void dispose() {
    // Destruye el StatefulWidget
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose(); // Limpiar evitar fuga de memoria

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                  return;
                }

                _controller.play();
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: Stack(children: [
                  VideoPlayer(_controller),


                  VideoBackground(stops: const [0.8, 1.0]),

                  
                  Positioned(
                      bottom: 50,
                      left: 20,
                      child: _VideoCaption(
                        caption: widget.caption,
                      ))
                ]),
              ),
            );
          }
        });
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.6, // 60%
      child: Text(
        caption,
        maxLines: 2,
        style: titleStyle,
      ),
    );
  }
}
