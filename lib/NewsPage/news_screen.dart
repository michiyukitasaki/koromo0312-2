import 'package:flutter/material.dart';

import 'const.dart';
import 'model.dart';

class ReadingNews extends StatefulWidget {
  final NewsApiModel model;

  const ReadingNews({required this.model, Key? key}) : super(key: key);

  @override
  State<ReadingNews> createState() => _ReadingNewsState();
}

class _ReadingNewsState extends State<ReadingNews> {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: getColors[0],
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: size.width / 1.05,
                  child: Text(
                    widget.model.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: size.height / 3,
                  width: size.width / 1.05,
                  alignment: Alignment.center,
                  child: widget.model.imageUrl != ""
                      ? Image.network(
                          widget.model.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Text(
                          "Unable to load image",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                Container(
                  width: size.width / 1.05,
                  child: Text(
                    widget.model.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
