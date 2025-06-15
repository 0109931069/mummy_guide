// import 'package:flutter/material.dart';
// import 'package:graduation_project/constans.dart';
// import 'package:graduation_project/helpers/rate_method.dart';
// import 'package:graduation_project/models/book_model.dart';
// import 'package:graduation_project/pages/book_info_screen.dart';
// import 'package:graduation_project/pages/books_reading_page.dart';
// //import 'package:graduation_project/pages/books_reading_page.dart';

// class CustomBookCard extends StatelessWidget {
//   final BookModel book;
//   const CustomBookCard({super.key, required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PDFViewerScreen(pdfUrl: book.pdfUrl),
//           ),
//         );
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   // ignore: use_full_hex_values_for_flutter_colors
//                   color: Color(0xff00000040),
//                   blurRadius: 4,
//                   offset: Offset(1, 1),
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Card(
//               color: const Color(0xffFFFFFF),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const SizedBox(height: 90),
//                     Center(
//                       child: Text(
//                         book.title,
//                         maxLines: 2,
//                         textDirection: TextDirection.rtl,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontFamily: kFontFamily,
//                           fontWeight: FontWeight.w300,

//                           color: Color(0xff000000),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           book.author,
//                           maxLines: 2,
//                           textDirection: TextDirection.rtl,
//                           style: TextStyle(
//                             fontFamily: kFontFamily,
//                             fontWeight: FontWeight.w300,

//                             color: Color(0xff777777),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         rateMethod(book.rate ?? 0.0),
//                         Text(
//                           book.rate.toString(),
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, BookInfoPage.id);
//                       },
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BookInfoPage(book: book),
//                               ),
//                             );
//                           },
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 'Read More',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xffFF8EA2),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(width: 4),
//                               Icon(
//                                 Icons.arrow_forward,
//                                 color: Color(0xffFF8EA2),
//                                 size: 16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 177,

//             left: 5,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(book.coverImage),
//                 ),
//               ),

//               height: 200,
//               width: 155,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:mummy_guide/helpers/rate_method.dart';
import 'package:mummy_guide/models/book_model.dart';
import 'package:mummy_guide/pages/book_info_screen.dart';
import 'package:mummy_guide/pages/pdf_viewer_screen.dart';

class CustomBookCard extends StatelessWidget {
  final BookModel book;
  const CustomBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerScreen(pdfUrl: book.pdfUrl),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 320,
            width: 160,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rateMethod(book.rate ?? 0.0),
                        Text(
                          book.rate.toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookInfoPage(book: book),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'اقرأ المزيد',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffFF8EA2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xffFF8EA2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  book.coverImage,
                  height: 160,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
