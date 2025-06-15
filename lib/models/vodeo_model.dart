class YoutubeVideoModel {
  final String title;
  final String url;
  final String image;

  YoutubeVideoModel({
    required this.title,
    required this.url,
    required this.image,
  });

  factory YoutubeVideoModel.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoModel(
      title: json['title'],
      url: json['url'],
      image: json['image'],
    );
  }
}
