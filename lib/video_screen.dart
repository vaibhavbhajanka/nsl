import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key, required this.letter,required this.image,required this.video}) : super(key: key);
  final String letter;
  final String image;
  final String video;
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  void _playVideo(String video) {
    // if(index<0 || index>=videos.length)
    _controller = VideoPlayerController.network(video)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  @override
  void initState() {
    super.initState();
    print(widget.video);
    _playVideo(widget.video);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: 'letter${widget.letter}',
              child: Image.network(widget.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.deepPurpleAccent,
              height: size.height * 0.3,
              child: _controller.value.isInitialized
                  ? Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.25,
                          child: VideoPlayer(_controller),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.02,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
