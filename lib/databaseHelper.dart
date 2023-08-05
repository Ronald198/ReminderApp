// ignore_for_file: no_leading_underscores_for_library_prefixes, non_constant_identifier_names, file_names
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminderapp/models/event.dart';
import 'package:reminderapp/services/event_sorter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as _path;


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase(); //if database doesnt exist, initialize db, else use the exsiting db

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = _path.join(documentsDirectory.path, 'reminderapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Events(
        eventId INTEGER PRIMARY KEY,
        eventDate TEXT,
        eventDesc TEXT
      );
    ''');
  }

  Future<List<Event>> getAllEvents() async { //GETS ALL FROM events //SELECT * FROM events
    Database db = await instance.database;
    var events = await db.query('Events'); 
    List<Event> eventsData = events.isNotEmpty ? events.map((e) => Event.fromMap(e)).toList() : []; //Gets data if events (if 1+ exists) or empty
    return eventsData;
  }

  Future<List<Event>> getAllEventsOfOneDay(String date) async { //GETS ALL FROM events //SELECT * FROM events WHERE event_date = ?
    Database db = await instance.database;
    try {
      var events = await db.rawQuery("SELECT * FROM events WHERE eventDate = ?", [date]); 
      List<Event> eventsData = events.isNotEmpty ? events.map((e) => Event.fromMap(e)).toList() : []; //Gets data if events (if 1+ exists) or empty
      return eventsData;
    } catch (e) {
      if (kDebugMode)
      {
        print(e);
      }
      rethrow;
    }
  }

  Future<int> insertNewEvent(Event event) async { //INSERTS NEW EVENT
    Database db = await instance.database;
    try {
      return await db.insert('Events', event.toMap()); 
    } catch (e) {
      if (kDebugMode)
      {
        print(e);
      }
      return 0;
    }
  }

  Future<int> deleteEventById(int eventId) async { //INSERTS NEW EVENT
    Database db = await instance.database;
    try {
      return await db.delete('Events', where: "eventId = ?", whereArgs: [eventId]); 
    } catch (e) {
      if (kDebugMode)
      {
        print(e);
      }
      return 0;
    }
  }

  Future<List<Event>> getTodaysEvents() async {
    List<Event> todaysEvents= await DatabaseHelper.instance.getAllEventsOfOneDay("${DateTime.now().month}_${DateTime.now().day}");
    return todaysEvents;
  }

  Future<List<Event>> getAllEventsSorted() async {
    List<Event> allEvents = await DatabaseHelper.instance.getAllEvents();
    allEvents = EventSorter.sortEvents(allEvents);
    return allEvents;
  }
}