import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_clone_flutter/Calendar/calendar_model/event.dart';
import 'package:instagram_clone_flutter/Calendar/calendar_widget/tasks_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../calendar_model/event_data_source.dart';
import '../provider/event_provider.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {


  MeetingDataSource? events;
  // final List<String> options = <String>['Add', 'Delete', 'Update'];

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {

      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }



  Future<void> getDataFromFireStore() async {
    final databaseReference = FirebaseFirestore.instance;
    var snapShotsValue = await databaseReference
        .collection("CalendarEvent")
        .get();
    // Map<String, dynamic> data = dataSnapshot.data!.docs[index].data() as Map<String, dynamic>;

    final Random random = new Random();
    List<Event> list = snapShotsValue.docs
        .map((e) => Event(
        title: e.data()['title'].toString(),
        from:e.data()['from'].toDate(),
        // from:DateFormat('dd/MM/yyyy HH:mm').parse(e.data()['from']),
        to: e.data()['to'].toDate(),
        // to : DateFormat('dd/MM/yyyy HH:mm').parse(e.data()['to']),
        description: e.data()['description'].toString(),
        // isAllDay: e.data()['isAllDay']
    ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
      final provider = Provider.of<EventProvider>(context,listen: false);
      for (var event in list){
        provider.addEvent(event);
      }
    });
  }

List<Color> _colorCollection = <Color>[];





  @override
  Widget build(BuildContext context) {
    // final events = Provider.of<EventProvider>(context).events;

    final provider = Provider.of<EventProvider>(context);
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(provider.events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.yellowAccent,
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true
      ),
      onLongPress: (details){
        final provider = Provider.of<EventProvider>(context,listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context,
            builder: (context)=> TasksWidget());
      },
    );

  }
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  String getDescription(int index) {
    return appointments![index].description;
  }


}



