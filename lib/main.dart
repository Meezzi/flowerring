import 'package:flowerring/pages/list/list_page.dart';
import 'package:flowerring/theme/dark.dart';
import 'package:flowerring/theme/light.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ListPage(),
    );
  }
}
