import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel/utils/models/destination_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  static final columnid = "id";
  static final columntitle = "title";
  static final columncity = "city";
  static final columnimage = "image";
  static final columndescription = "description";
  static final columnfounded = "founded";
  static final columnpopulation = "population";
  static final columnunite = "unite";
  static final columncountry = "country";

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the DestinationIt table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'destination_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE DestinationIt('
          '$columnid INTEGER PRIMARY KEY,'
          '$columntitle TEXT,'
          '$columncity TEXT,'
          '$columnimage TEXT,'
          '$columndescription TEXT,'
          '$columnfounded TEXT,'
          '$columnpopulation TEXT,'
          '$columnunite INT,'
          '$columncountry INT'
          ')');
    });
  }

  // Insert DestinationIt on database
  createDestinationIt(DestinationIt newDestinationIt) async {
    await deleteAllDestinationIts();
    final db = await database;
    await db.insert('DestinationIt', newDestinationIt.toJson());
    print("Osama Is inserted!!");
    final q = await db.query('DestinationIt');
    return q;
  }
  Future<int> insertDestinationIt(Map<String, dynamic> row) async {
    await deleteAllDestinationIts();
    Database db = await database;
    final res = await db.insert('DestinationIt', row);
    print("Osama Is inserted!!");
    return res;
  }
    Future<List<Map<String, dynamic>>> queryAllRowsDestinationIt() async {
    Database db = await database;
    return await db.query('DestinationIt');
  }
  // Delete all DestinationIts
  Future<int> deleteAllDestinationIts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM DestinationIt');

    return res;
  }

  Future<List<DestinationIt>> getAllDestinationIts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM DestinationIt");

    List<DestinationIt> list =
        res.isNotEmpty ? res.map((c) => DestinationIt.fromJson(c)).toList() : [];

    return list;
  }
}