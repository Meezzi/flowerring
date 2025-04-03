import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flowerring.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE PRODUCT_TB (
        PRODUCT_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        PRODUCT_NAME VARCHAR(55) NOT NULL,
        PRODUCT_PRICE INTEGER NOT NULL,
        PRODUCT_CNT INTEGER NOT NULL,
        PRODUCT_DESC TEXT NOT NULL
      )
    ''');

    await db.execute('''
        CREATE TABLE REVIEW_TB (
          REVIEW_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          PRODUCT_ID INTEGER NOT NULL,
          REVIEW_TEXT TEXT NOT NULL,
          REVIEW_RATING INTEGER NOT NULL,
          FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT_TB(PRODUCT_ID) ON DELETE CASCADE,
          FOREIGN KEY (USER_ID) REFERENCES USERS_TB(USER_ID) ON DELETE CASCADE
        )
      ''');

    await db.execute('''
      CREATE TABLE WISHLIST_TB (
        USER_ID INTEGER NOT NULL,
        PRODUCT_ID INTEGER NOT NULL,
        QUANTITY INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (USER_ID) REFERENCES USERS_TB(USER_ID) ON DELETE CASCADE,
        FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT_TB(PRODUCT_ID) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE USER_TB (
        USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        USER_SIR VARCHAR(55) NOT NULL,
        USER_NAME VARCHAR(55) NOT NULL
      )
    ''');
  }
}
