import 'package:flutter/material.dart';

final String tableEvents = 'events';

class EventFilds {
  static final List<String> values = [
    id,
    title,
    description,
    from,
    to,
    background,
    isAllDay
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String from = 'from';
  static final String to = 'to';
  static final String background = 'background';
  static final String isAllDay = 'isAllDay';
}

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.lightGreen,
    this.isAllDay = false,
  });

  Event copy({
    int? id,title,description,from,to, backgroundColor, isAllDay
  }) =>
      Event(
          title: title ?? this.title,
          description : description ?? this.description,
          from: from ?? this.from,
          to : to ?? this.to,
          backgroundColor: backgroundColor ?? this.backgroundColor,
          isAllDay: isAllDay ?? this.isAllDay,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
      // id:json[EventFilds.id] as int,
      title: json[EventFilds.title] as String,
      from: DateTime.parse(json[EventFilds.from] as String),
      to: DateTime.parse(json[EventFilds.to] as String),
      description: json[EventFilds.description] as String,
      backgroundColor: json[EventFilds.background] as Color,
      isAllDay: json[EventFilds.isAllDay] == 1
  );

  Map<String, Object?> toJson() =>{
    EventFilds.title:title,
    EventFilds.from:from.toIso8601String(),
    EventFilds.to:to.toIso8601String(),
    EventFilds.description:description,
    EventFilds.background:backgroundColor,
    EventFilds.isAllDay:isAllDay ? 1 : 0
    };
}
//
//
// class NoteFilds {
//   static final List<String> values = [
//     id, isImportant, number, title, description, createdTime
//   ];
//
//   static final String id = '_id';
//   static final String isImportant = 'isImportant';
//   static final String number = 'number';
//   static final String title = 'title';
//   static final String description = 'description';
//   static final String createdTime = 'createdTime';
// }
//
// class Note {
//   final int? id;
//   final bool isImportant;
//   final int number;
//   final String title;
//   final String description;
//   final DateTime createdTime;
//
//   const Note({
//     this.id,
//     required this.isImportant,
//     required this.number,
//     required this.title,
//     required this.description,
//     required this.createdTime
//   });
//
//   Note copy({
//     int? id, isImportant, required int number, title, description,
//   }) =>
//       Note(
//           isImportant: isImportant ?? this.isImportant,
//           number: number ?? this.number,
//           title: title ?? this.title,
//           description: description ?? this.description,
//           createdTime: createdTime ?? this.createdTime
//       );
//
//   static Note fromJson(Map<String, Object?> json) => Note(
//       id: json[NoteFilds.id] as int?,
//       isImportant: json[NoteFilds.isImportant] == 1,
//       number: json[NoteFilds.number] as int,
//       title: json[NoteFilds.title] as String,
//       description: json[NoteFilds.description] as String,
//       createdTime: DateTime.parse(json[NoteFilds.createdTime] as String)
//   );
//
//   Map<String, Object?> toJson() =>{
//     NoteFilds.id : id,
//     NoteFilds.title:title,
//     NoteFilds.isImportant:isImportant ? 1 : 0,
//     NoteFilds.description:description,
//     NoteFilds.createdTime:createdTime.toIso8601String()
//   };
//
// }
