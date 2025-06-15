import 'package:flutter/material.dart';
import 'package:mummy_guide/models/book_model.dart';
import 'package:mummy_guide/widgets/custom_book_card.dart';

class AllBooksList extends StatelessWidget {
  final List<BookModel> books;
  const AllBooksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CustomBookCard(book: books[index]),
          childCount: books.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16, // تقليل المسافة بين الصفوف
          crossAxisSpacing: 8, // مسافة بين الأعمدة
          childAspectRatio: 0.5, // نسبة العرض للارتفاع
        ),
      ),
    );
  }
}
