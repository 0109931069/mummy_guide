import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  static const String _baseUrl =
      "https://eng-bassant-mummyguide.hf.space/search";

  static Future<List<Map<String, String>>> searchVideos(
    String query, {
    int topK = 7,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"query": query, "top_k": topK}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data["results"];

        return results.map<Map<String, String>>((item) {
          return {
            "title": item["title"] ?? "",
            "description": item["description"] ?? "",
          };
        }).toList();
      } else {
        throw Exception("فشل في جلب البيانات من السيرفر");
      }
    } catch (e) {
      throw Exception("حدث خطأ أثناء الاتصال: $e");
    }
  }
}
