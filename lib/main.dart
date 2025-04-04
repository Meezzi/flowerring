import 'package:flowerring/core/database_core.dart';
import 'package:flowerring/list/list_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  //데이터베이스 초기화
  await DatabaseHelper.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ListPage());
  }
}
