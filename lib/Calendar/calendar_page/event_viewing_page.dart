
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/Calendar/calendar_model/event.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';
import 'event_editting_page.dart';



class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event
  }):super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown,Colors.black12],
            begin: const FractionalOffset(0.0, 0.0),
            end:  const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      title: Text(
        '予定詳細',
        style: TextStyle(
            fontSize: 30, color: Colors.white, fontFamily: 'Signatra'),
      ),
      centerTitle: true,
      leading: CloseButton(),
      actions: buildViewingAction(context,event),
    ),
    body: ListView(
      padding: EdgeInsets.all(32),
      children:<Widget> [
        Container(child: buildDateTime(event),alignment: Alignment.topLeft,),
        SizedBox(height: 32,),
        Text(
            'タイトル：\n${event.title}',
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.red),
        ),
        const SizedBox(height: 24,),
        Text(
          '詳細：\n${event.description}',
          style: TextStyle(
              color:Colors.white,
              fontSize: 18),
        )
      ],
    ),
  );

  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate(event.isAllDay ? '終日' :'From', event.from),
        if(!event.isAllDay) buildDate('To',event.to)
      ],
    );
  }
  Widget buildDate(String title, DateTime date){
    return Text('$title  ${DateFormat('M月d日HH時').format(date)}');
  }

  List<Widget> buildViewingAction(BuildContext context,Event event){
   return[
   IconButton(
     icon: Icon(Icons.edit),
     onPressed: () => Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => EventEditingPage(event: event),
         )),
   ),
   IconButton(
     icon: Icon(Icons.delete),
     onPressed: (){
       final provider = Provider.of<EventProvider>(context,listen: false);
       provider.deleteEvent(event);
     },
   )
   ];
  }


  }

