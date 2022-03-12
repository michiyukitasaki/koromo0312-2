
import 'package:flutter/material.dart';

import '../../widgets/myDrawer.dart';
import '../calendar_widget/calendar_widget.dart';
import 'event_editting_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   refreshEvents();
  // }
  //
  // @override
  // void dispose() {
  //   EventDatabases.instance.close();
  //   super.dispose();
  // }
  //
  // Future refreshEvents() async {
  //   setState(() => isLoading = true);
  //   this.events = await EventDatabases.instance.readAllNote();
  //   setState(() => isLoading = false);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarNoAction(title: 'スケジュール', bottom: null,),
      appBar: AppBar(title: Text('スケジュール'),),
      drawer: MyDrawer(),
      body: CalendarWidget(),
      // body: CalenderTestWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.brown[300],
        onPressed: () =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage())
            ),
      ),
    );
  }
}
