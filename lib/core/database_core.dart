import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // 싱글톤 패턴 적용: 앱에서 하나의 데이터베이스 인스턴스만 사용하도록 설정
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();


  ///데이터베이스를 가져오는 함수
  ///이미 데이터베이스가 생성되어 있으면 기존 데이터베이스 반환
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flowerring.db');
    return _database!;
  }

  ///데이터베이스 초기화 함수
  ///앱의 내부 저장소에서 데이터베이스 파일을 생성하거나 불러오는 역활
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    //데이터베이스 열기 (없으면 새로 생성), 버전이 변경되면 onCreate가  실행됨
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  ///데이터베이스 테이블 생성 함수
  Future<void> _createDB(Database db, int version) async {
    //상품 테이블 PRODUCT_TB
    await db.execute('''
      CREATE TABLE PRODUCT_TB (
        PRODUCT_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
        PRODUCT_NAME VARCHAR(55) NOT NULL,
        PRODUCT_PRICE INTEGER NOT NULL,
        PRODUCT_CNT INTEGER NOT NULL,
        PRODUCT_DESC TEXT NOT NULL
      )
    ''');
    //리뷰 테이블 REVIEW_TB
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
    //장바구니 테이블 WISHLIST_TB
    await db.execute('''
      CREATE TABLE WISHLIST_TB (
        USER_ID INTEGER NOT NULL,
        PRODUCT_ID INTEGER NOT NULL,
        QUANTITY INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (USER_ID) REFERENCES USERS_TB(USER_ID) ON DELETE CASCADE,
        FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT_TB(PRODUCT_ID) ON DELETE CASCADE
      )
    ''');
    //유저 테이블 USER_TB
    await db.execute('''
      CREATE TABLE USER_TB (
        USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        USER_SIR VARCHAR(55) NOT NULL,
        USER_NAME VARCHAR(55) NOT NULL
      )
    ''');
  }
}
