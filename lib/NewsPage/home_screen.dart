import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'const.dart';
import 'model.dart';
import 'news_api.dart';
import 'news_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<NewsApiModel>? newsList;
  bool isLoading = true;
  TextEditingController topicController = TextEditingController();
  String topicText = 'dog';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews('puppy').then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newsList = value;
          isLoading = false;
        } else {
          print("List is Empty");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text('最新ニュース'),
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
                            hintText: '検索ワードを入力してください'
                        ),
                        // onChanged: (text){
                        //   topicText = text;
                        // },
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: (){
                                getNews(topicController.text).then((value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  newsList = value;
                                  isLoading = false;
                                } else {
                                  print("List is Empty");
                                }
                              });
                            }
                            );
                          },
                          child: Text('検索する'))
                    ],
                  ),
                ),
              ),
            )
        ),
        backgroundColor: Colors.black,
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              // Container(
              //   height: size.height / 12,
              //   width: size.width / 1.1,
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.menu,
              //         // color: Colors.white,
              //       ),
              //       SizedBox(
              //         width: size.width / 4,
              //       ),
              //       Text(
              //         "Newsページ",
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontWeight: FontWeight.w500,
              //           //color: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              isLoading
                  ? Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: newsList!.length,
                          itemBuilder: (context, index) {
                            return listItems(size, newsList![index]);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(Size size, NewsApiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReadingNews(
              model: model,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          width: size.width / 1.15,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: size.width / 1.05,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                child: model.imageUrl != ""
                    ? Image.network(
                        model.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Text("Cant Load image"),
              ),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed:  (){ _launchInApp(model.url);}, child: Text('サイトに移動')),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _launchInApp(String u) async {
    String url = u;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
