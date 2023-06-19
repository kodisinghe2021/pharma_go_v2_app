// import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  //----------- create and initialize the db
  static Future<Database> initDB() async {
    //store db in the device
    /* 
  on android data/data
  on IOS document derectory
  */
    final dbPath = await getDatabasesPath();

    // best pratcie from flutter documenttaion
    final path = join(dbPath, 'cart.db');

    // this will open the database
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        // for creating table need to exectue query
        await createTables(database);
      },
    );
  }

  //-------------------create tables
  static Future<void> createTables(Database database) async {
    await database.execute("""
          CREATE TABLE CartItems (
	          id INTEGER PRIMARY KEY AUTOINCREMENT,
   	        title TEXT,
	          description TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
          )
         """);
      
  }

  //-------------------- insert data to table
  static Future<void> createCartItem(Map<String,dynamic> cartMap) async {
    final db = await initDB();

    // map
    final data = cartMap;

    await db.insert('CartItems', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // retrieve data from table
  static Future<List<Map<String, dynamic>>> readTable() async {
    final db = await initDB();

    final result = await db.query('CartItems');

    return result;
  }

  // remove item from cart
  static Future<int> deleteData(int id) async {
    final db = await initDB();
    int deletedId = await db.delete('Notes', where: 'id = ?', whereArgs: [id]);
    return deletedId;
  }
}
