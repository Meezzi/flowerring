import 'package:flowerring/pages/registration/registration_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: ListPage());
    return MaterialApp(home: RegistrationPage());
  }
}
