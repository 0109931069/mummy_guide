import 'package:flutter/material.dart';
import 'package:mummy_guide/constants.dart';
import 'package:mummy_guide/helpers/rate_method.dart';
import 'package:mummy_guide/models/book_model.dart';

import 'package:mummy_guide/pages/pdf_viewer_screen.dart';

class BookInfoPage extends StatelessWidget {
  final BookModel book;
  static String id = 'BookInfoScreen';
  const BookInfoPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final coverImage = NetworkImage(book.coverImage);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '📖 تفاصيل الكتاب',
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: kFontFamily,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              book.coverImage,
              height: 256,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              book.title,
              textDirection: TextDirection.rtl,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff4F4F4F),
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: kFontFamily,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  book.author,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xff4F4F4F),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: kFontFamily,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(radius: 30, backgroundImage: coverImage),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${book.rate}', style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              rateMethod(book.rate ?? 0.0),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'وصف الكتاب',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Color(0xff333333),
              fontFamily: kFontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.summary,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Color(0xff4F4F4F),
              fontFamily: kFontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerScreen(pdfUrl: book.pdfUrl),
                  ),
                );
              },
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text(
                'ابدأ القراءة الآن',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF8EA2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
