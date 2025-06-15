import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class AllBookService {
  static Future<List<BookModel>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://mervat99-001-site1.qtempurl.com/api/Books'),
    );

    try {
      final data = json.decode(response.body);
      if (data is List) {
        return data.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw Exception('البيانات مش List');
      }
    } catch (e) {
      throw Exception('فشل في قراءة البيانات');
    }
  }
}
