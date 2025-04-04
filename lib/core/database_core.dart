import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class DatabaseHelper {
  // 싱글톤 패턴 적용: 앱에서 하나의 데이터베이스 인스턴스만 사용하도록 설정
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  final uuid = Uuid(); // UUID 생성기

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

    //초기 유저 데이터 삽입
    final userSir = uuid.v4();
    final userName = _generateRandomKoreanName();
    await db.insert('USER_TB', {'USER_SIR': userSir, 'USER_NAME': userName});
  }

  // ------------------- USER_TB -------------------
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('USER_TB', user);
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await instance.database;
    return await db.query('USER_TB');
  }

  Future<Map<String, dynamic>?> fetchUserBySir(String userSir) async {
    final db = await instance.database;
    final result = await db.query(
      'USER_TB',
      where: 'USER_SIR = ?',
      whereArgs: [userSir],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ------------------- PRODUCT_TB -------------------
  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await instance.database;
    return await db.insert('PRODUCT_TB', product);
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final db = await instance.database;
    return await db.query('PRODUCT_TB');
  }

  Future<Map<String, dynamic>?> fetchProductById(int productId) async {
    final db = await instance.database;
    final result = await db.query(
      'PRODUCT_TB',
      where: 'PRODUCT_ID = ?',
      whereArgs: [productId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ------------------- REVIEW_TB -------------------
  Future<int> insertReview(Map<String, dynamic> review) async {
    final db = await instance.database;
    return await db.insert('REVIEW_TB', review);
  }

  Future<List<Map<String, dynamic>>> fetchReviews() async {
    final db = await instance.database;
    return await db.query('REVIEW_TB');
  }

  Future<List<Map<String, dynamic>>> fetchReviewsByProductId(
    int productId,
  ) async {
    final db = await instance.database;
    return await db.query(
      'REVIEW_TB',
      where: 'PRODUCT_ID = ?',
      whereArgs: [productId],
    );
  }

  // ------------------- WISHLIST_TB -------------------
  Future<int> insertWishlistItem(Map<String, dynamic> wishlistItem) async {
    final db = await instance.database;
    return await db.insert('WISHLIST_TB', wishlistItem);
  }

  Future<List<Map<String, dynamic>>> fetchWishlist() async {
    final db = await instance.database;
    return await db.query('WISHLIST_TB');
  }

  Future<List<Map<String, dynamic>>> fetchWishlistByUserId(int userId) async {
    final db = await instance.database;
    return await db.query(
      'WISHLIST_TB',
      where: 'USER_ID = ?',
      whereArgs: [userId],
    );
  }

  //랜덤한 한글 닉네임 생성 함수
  String _generateRandomKoreanName() {
    final firstname = ['김', '이', '박', '최', '정', '강', '조', '윤', '장', '임'];
    final names = ['민수', '서연', '지후', '하은', '예준', '수아', '도윤', '지민', '서준', '현우'];

    final rand = Random();
    return firstname[rand.nextInt(firstname.length)] +
        names[rand.nextInt(names.length)];
  }
}
