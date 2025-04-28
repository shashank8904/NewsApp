import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/articleModel.dart';

class NewsApiService {
  static const String apiKey = '7730a613aaf5487ba0ab61dbbd3c2367';
  static const String baseUrl = 'https://newsapi.org/v2';

  static Future<List<Article>> fetchNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List articles = data['articles'];
      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
