import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cek_gizi/models/gizi.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper.createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper.createObject();
    }
    return _dbHelper;
  }
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'gizi.db';

    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE gizi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        jk TEXT,
        usia INT,
        beratBadan REAL,
        tinggiBadan REAL,
        hasil REAL
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('gizi', orderBy: 'name');
    return mapList;
  }

// create
  Future<int> insert(Gizi object) async {
    Database db = await this.database;
    Map<String, dynamic> ob = object.toMap();
    int count = await db.insert('gizi', ob);
    return count;
  }

// update
  Future<int> update(Gizi object) async {
    Database db = await this.database;
    int count = await db
        .update('gizi', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('gizi', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Gizi>> getContactList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Gizi> contactList = List<Gizi>();
    for (int i = 0; i < count; i++) {
      contactList.add(Gizi.fromMap(contactMapList[i]));
    }
    return contactList;
  }
}
