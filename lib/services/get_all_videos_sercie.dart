import 'dart:convert';
import 'package:mummy_guide/models/vodeo_model.dart';
import 'package:http/http.dart' as http;

class VideoService {
  static Future<List<YoutubeVideoModel>> fetchVideos() async {
    const url = 'https://68071391e81df7060eb8bf80.mockapi.io/api/v1/videos';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        if (data is List) {
          return data.map((json) => YoutubeVideoModel.fromJson(json)).toList();
        } else {
          throw Exception('البيانات اللي راجعة مش List');
        }
      } catch (e) {
        throw Exception('فشل في قراءة البيانات: $e');
      }
    } else {
      throw Exception('فشل في تحميل البيانات. كود: ${response.statusCode}');
    }
  }
}
