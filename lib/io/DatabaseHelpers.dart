import 'dart:io';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // Database table and column names for the Film Development Order
  static final String tableOrders = 'filmorders';
  static final String columnId = '_id';
  static final String columnOrderNumber = 'orderNumber';
  static final String columnStoreId = 'storeId';
  static final String columnInsertionDate = 'insertionDate';
  static final String columnStoreModel = 'storeModelID';
  static final String columnStatusStatusDate = 'statusDate';
  static final String columnStatusFetchTime = 'statusFetchTime';
  static final String columnStatusStatusSummary = 'statusSummary';
  static final String columnStatusPrice = 'statusPrice';
  static final String columnStatusStatusSummaryText = 'statusSummaryText';

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "FilmOrderDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableOrders (
                $columnId INTEGER PRIMARY KEY,
                $columnOrderNumber TEXT NOT NULL,
                $columnStoreId TEXT NOT NULL,
                $columnInsertionDate INTEGER NOT NULL,
                $columnStoreModel TEXT NOT NULL,
                $columnStatusStatusDate INTEGER,
                $columnStatusFetchTime INTEGER,
                $columnStatusPrice REAL,
                $columnStatusStatusSummaryText TEXT,
                $columnStatusStatusSummary INTEGER
              )
              ''');
  }

  Future<int> insert(FilmDevelopmentOrder order) async {
    Database db = await database;
    int id = await db.insert(tableOrders, order.toMap());
    print("Order has been inserted to Databse");
    return id;
  }

  Future<FilmDevelopmentOrder> queryFilmDevelopmentOrder(int id) async {
    Database db = await database;
    List<Map> maps =
        await db.query(tableOrders, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return FilmDevelopmentOrder.fromMap(maps.first);
    }
    return null;
  }

  Future<List<FilmDevelopmentOrder>> loadAllFilmDevelopmentOrders() async {
    Database db = await database;
    List<Map> maps =
        await db.query(tableOrders, orderBy: "$columnInsertionDate DESC");

    List<FilmDevelopmentOrder> loadedOrders = new List();
    maps.forEach(
        (order) => loadedOrders.add(FilmDevelopmentOrder.fromMap(order)));
    return loadedOrders;
  }

  Future<int> delete(FilmDevelopmentOrder orderToBeDeleted) async {
    Database db = await database;
    int val = await db.delete(tableOrders,
        where: '$columnId = ?', whereArgs: [orderToBeDeleted.id]);
    print("$val rows deleted");
    return val;
  }

  Future<int> update(FilmDevelopmentOrder orderToBeUpdated) async {
    Database db = await database;
    int val = await db.update(tableOrders, orderToBeUpdated.toMap(),
        where: '$columnId = ?', whereArgs: [orderToBeUpdated.id]);
    print("$val rows updated");
    return val;
  }
}
