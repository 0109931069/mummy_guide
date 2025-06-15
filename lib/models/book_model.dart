class BookModel {
  final String title;
  final String pdfUrl;
  final String coverImage;
  final String author;
  final String summary;
  final double? rate;

  BookModel({
    required this.title,
    required this.pdfUrl,
    required this.author,
    required this.summary,
    required this.rate,
    required this.coverImage,

    // required this.coverImage,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'], // utf8.decode(json['title'].toString().codeUnits),
      pdfUrl: json['pdfUrl'],
      author: json['author'],
      summary: json['summary'],
      rate: json['rate'],
      coverImage: json['coverImageUrl'],
    );
  }
}
