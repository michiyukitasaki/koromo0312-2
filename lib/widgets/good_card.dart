import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoodCard extends StatefulWidget {
  final snap;
  const GoodCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<GoodCard> createState() => _GoodCardState();

}


List goodpersonsGet(snap){
  final person;
  List goodPersons = [];
  for(person in snap){
    goodPersons.add(person);
  }
  return goodPersons;
}


class _GoodCardState extends State<GoodCard> {
  @override
  Widget build(BuildContext context) {

    final List persons = goodpersonsGet(widget.snap);



    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').where('uid',whereIn: persons).snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        print('ok');
        return ListView.builder(

          itemCount: snapshot.data!.docs.length,
          itemBuilder: (ctx, index) {
            return Container(
            height: 100,
              color: Colors.red,
          );
          }
        );
      },
    );
  }
}
