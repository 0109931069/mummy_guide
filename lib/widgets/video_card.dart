import 'package:flutter/material.dart';
import 'package:mummy_guide/models/vodeo_model.dart';
import 'package:mummy_guide/pages/video_player_page.dart';

class VideoCard extends StatelessWidget {
  final YoutubeVideoModel videoModel;
  const VideoCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VideoPlayerPage(youtubeUrl: videoModel.url);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الفيديو مع أيقونة تشغيل
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    videoModel.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      size: 65,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // عنوان الفيديو فقط
            Text(
              videoModel.title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff222222),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
