import 'package:flutter/material.dart';

import 'nesw_feed_page.dart';

class SelectNewsPage extends StatefulWidget {
  const SelectNewsPage({Key key}) : super(key: key);

  @override
  State<SelectNewsPage> createState() => _SelectNewsPageState();
}

class _SelectNewsPageState extends State<SelectNewsPage> {
  String topicText = '経済';
  TextEditingController topic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: topic,
              decoration: InputDecoration(
                hintText: 'ニューストピック'
              ),
              onChanged: (text){
                topicText = text;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if(topic.text != null){
                    final topicText = topic.text;
                  } else {topicText = 'サッカー';}
                  Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=> NewsFeedPage(topic: topicText,))
                  );
                },
                child: Text('検索'))
          ],
        ),
      ),
    );
  }
}
