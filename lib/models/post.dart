import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  final String othertext;
  final double conditionnumber;
  final DateTime fromDate;
  final double recomend;
  final String isSelectedItem;

  const Post(
      {required this.description,
        required this.uid,
        required this.username,
        required this.likes,
        required this.postId,
        required this.datePublished,
        required this.postUrl,
        required this.profImage,
        required this.othertext,
        required this.conditionnumber,
        required this.fromDate,
        required this.recomend,
        required this.isSelectedItem,
      });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],

        othertext: snapshot["othertext"],
        conditionnumber: snapshot["conditionnumber"],
        fromDate: snapshot["fromDate"],
        recomend: snapshot['recomend'],
        isSelectedItem: snapshot['isSelectedItem']
    );
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "uid": uid,
    "likes": likes,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    'postUrl': postUrl,
    'profImage': profImage,
    'othertext': othertext,
    'conditionnumber': conditionnumber,
    ' fromDate': fromDate,
    'recomend':recomend,
    'isSelectedItem': isSelectedItem
  };
}
