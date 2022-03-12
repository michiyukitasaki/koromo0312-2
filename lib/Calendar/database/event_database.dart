


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../calendar_model/event.dart';

class EventDatabases {
  static final EventDatabases instance = EventDatabases._init();
  static Database? _database;
  EventDatabases._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('events.db');
    return _database!;
  }


  Future<Database> _initDB(String filePath)async{
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }


  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'Text NOT NULL';

    await db.execute('''
    CREATE TABLE $tableEvents(
    ${EventFilds.id} $idType,
    ${EventFilds.title} $textType,
    ${EventFilds.from} $textType,
    ${EventFilds.to} $textType,
    ${EventFilds.background} $textType,
    ${EventFilds.description}  $textType,
    ${EventFilds.isAllDay} $boolType,
    ${EventFilds.from}  $textType,
    )
    ''');


  }

  Future<Event> create(Event event) async{
    final db = await instance.database;
    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id:id);
  }

  Future<Event> readEvent(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableEvents,
      columns: EventFilds.values,
      where: '${EventFilds.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty){
      return Event.fromJson(maps.first);
    } else {
      throw Exception('ID $id not fonud');
    }
  }

  Future<List<Event>> readAllNote() async{
    final db = await instance.database;
    final result = await db.query(tableEvents);
    return result.map((json) => Event.fromJson(json)).toList();
  }

  Future<int> update(Event event) async {
    final db = await instance.database;
    return db.update(
        tableEvents,
        event.toJson(),
        where: '${EventFilds.id} = ?',
        // whereArgs: [event.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
        tableEvents,
        where: '${EventFilds.id} = ?',
        whereArgs: [id]
    );
  }


  Future close() async{
    final db = await instance.database;
    db.close();
  }

}
