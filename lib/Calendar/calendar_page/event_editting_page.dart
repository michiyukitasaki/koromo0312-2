
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter/Calendar/calendar_model/event.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/event_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({
    Key? key,
    this.event
}):super(key: key);



  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}
class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;
  final titleController = TextEditingController();
  final bool isAllDay = false;
  final descriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();

    if (widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }else{
      final event = widget.event!;
      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose(){
    titleController.dispose();
    descriptionController.dispose();
  super.dispose();
  }

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
        '編集',
        style: TextStyle(
            fontSize: 50, color: Colors.white, fontFamily: 'Signatra'),
      ),
      centerTitle: true,
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
            SizedBox(height: 12,),
            buildDateTimePickers(),
            SizedBox(height: 24,),
            buildDescription(),
          ],
        ),
      ),
    ),
  );

  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent
      ),
        icon: Icon(Icons.done),
        label: Text('保存'),
      onPressed: saveForm,
    )
  ];

  Widget buildTitle() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: 'タイトルを追加'
    ),
    onFieldSubmitted: (_)=>saveForm(),
    controller: titleController,
    validator: (title) =>
    title != null && title.isEmpty ? 'タイトルを入力して下さい':null,
  );

  Widget buildDescription() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: '詳細を追加'
    ),
    onFieldSubmitted: (_)=>saveForm(),
    controller: descriptionController,
    validator: (title) =>
    title != null && title.isEmpty ? '詳細を入力して下さい':null,
  );



  Widget buildDateTimePickers() => Column(
    children: [
      buildForm(),
      buildTo()
    ],
  );

  Widget buildForm() => buildHeader(
    header:'開始時間',
    child: Row(
      children: [
        Expanded(child: buildDropdownField(
          text: DateFormat('M月d日').format(fromDate)    ,
          onClicked:()=> pickFromDateTime(pickDate:true)
        )),
        Expanded(child: buildDropdownField(
            text: DateFormat('HH時MM分').format(fromDate)  ,
            onClicked:()=> pickFromDateTime(pickDate:false)
        ))

      ],
    ),
  );

  Widget buildTo() => buildHeader(
    header:'終了時間',
    child: Row(
      children: [
        Expanded(child: buildDropdownField(
            text: DateFormat('M月d日').format(toDate)    ,
            onClicked:()=> pickToDateTime(pickDate:true)
        )),
        Expanded(child: buildDropdownField(
            text: DateFormat('HH時MM分').format(toDate)  ,
            onClicked:()=> pickToDateTime(pickDate:false)
        ))

      ],
    ),
  );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate,pickDate:pickDate);
    if(date == null) return;
    setState(() => fromDate = date );
    // toDate = DateTime(datefrom.year, datefrom.month,datefrom.day, fromDate.hour, fromDate.minute);
    if (date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month,date.day, toDate.hour, toDate.minute);
    }

  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,pickDate:pickDate);
    if(date == null) return;
    setState(() => toDate = date );
    }




  Future<DateTime?> pickDateTime(
      DateTime initialDate,{
        required bool pickDate,
        DateTime? firstDate,
        }) async {
        if(pickDate){
          final date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate ?? DateTime(2018),
              lastDate: DateTime(2050));
          if(date==null) return null;
          final time =
              Duration(hours: initialDate.hour, minutes: initialDate.minute);

          return date.add(time);
        } else{
          final timeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(initialDate));
          if(timeOfDay == null)return null;

          final date = DateTime(
              initialDate.year,
              initialDate.month,
              initialDate.day);
          final time = Duration(
              hours: timeOfDay.hour,
              minutes: timeOfDay.minute
          );
          return date.add(time);
        }
       }


  Widget buildDropdownField({
  required String text,
    required VoidCallback onClicked,
}) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked,
  );

  Widget buildHeader({
  required String header,
    required Widget child,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,style: TextStyle(fontWeight: FontWeight.bold),),
          child
        ],
      );

  Future saveForm()async{
    final isValid = _formKey.currentState!.validate();
    final eventPublishTime = DateTime.now();

    if(isValid){
      final event = Event(
        // id: ,
          title: titleController.text,
          description: descriptionController.text,
          from: fromDate,
          to: toDate,
          isAllDay:false,
      );
          FirebaseFirestore.instance
          .collection("CalendarEvent")
          .doc(eventPublishTime.toString())
          .set({
        'title': titleController.text,
            'description': descriptionController.text,
        'from': fromDate,
        'to': toDate,
            'isAllDay':isAllDay
      });

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context,listen: false);

      if(isEditing){
        provider.editEvent(event, widget.event!);
        Navigator.of(context).pop();
      }else {
        provider.addEvent(event);
        Navigator.of(context).pop();
      }
    }
  }
}
