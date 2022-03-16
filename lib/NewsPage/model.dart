class NewsApiModel {
  String title, imageUrl, content, description, url;

  NewsApiModel(
      {required this.title,
      required this.description,
      required this.content,
      required this.imageUrl,
      required this.url
      });

  factory NewsApiModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsApiModel(
      title: jsonData['title'] ?? "",
      description: jsonData['description'] ?? "",
      content: jsonData['content'] ?? "",
      imageUrl: jsonData['urlToImage'] ?? "",
      url: jsonData['url'] ?? "",
    );
  }
}
