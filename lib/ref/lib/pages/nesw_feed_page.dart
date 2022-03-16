import 'package:flutter/material.dart';

import '../components/customListTile.dart';
import '../model/article_model.dart';
import '../services/api_service.dart';


class NewsFeedPage extends StatefulWidget {
  // String topic = 'dog';
  // NewsFeedPage({this.topic});


  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  ApiService client = ApiService();
  String topicText = '犬';
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text('ニュース', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 100.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  TextField(
                    controller: topicController,
                    decoration: InputDecoration(
                        hintText: '検索ワード'
                    ),
                    // onChanged: (text){
                    //   topicText = text;
                    // },
                  ),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          topicText = topicController.text;
                        });
                      },
                      child: Text('検索'))
                ],
              ),
            ),
          ),
        ),
      ),

      //Now let's call the APi services with futurebuilder wiget
      body: FutureBuilder(
        future: client.getArticle(topicText),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<Article> articles = snapshot.data;
            return ListView.builder(
              //Now let's create our custom List tile
              itemCount: 10,
              itemBuilder: (context, index) =>
                  customListTile(articles[index], context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
