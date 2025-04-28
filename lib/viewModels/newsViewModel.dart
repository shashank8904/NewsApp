import 'package:flutter/cupertino.dart';
import 'package:news/models/articleModel.dart';
import 'package:news/services/newsApiService.dart';

class NewsViewModel with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await NewsApiService.fetchNews();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
