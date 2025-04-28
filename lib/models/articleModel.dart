class Article {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
