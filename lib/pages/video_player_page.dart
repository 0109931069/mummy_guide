import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  static String id = 'VideoPlayerPage';
  final String youtubeUrl;

  const VideoPlayerPage({super.key, required this.youtubeUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // استخراج ID من رابط اليوتيوب
    final videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl)!;

    // إنشاء الكونترولر
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الكونترولر لما الشاشة تقفل
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }
}
