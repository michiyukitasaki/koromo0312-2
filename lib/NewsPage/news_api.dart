import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

Future<List<NewsApiModel>> getNews(String q) async {
  // String q = 'dog';
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/everything?q='${q}'&from=2022-02-16&sortBy=publishedAt&apiKey=a5e78f194bf44ef4908f5405810114e5");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<NewsApiModel> newsList = _articalsList
        .map((jsonData) => NewsApiModel.fromJson(jsonData))
        .toList();

    print(_articalsList);

    return newsList;
  } else {
    print("error");
    return [];
  }
}
