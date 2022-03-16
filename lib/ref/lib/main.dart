import 'package:NewsApp/pages/home_page.dart';
import 'package:NewsApp/pages/nesw_feed_page.dart';
import 'package:NewsApp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsFeedPage(),
    );
  }
}
