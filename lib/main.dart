import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:path_provider/path_provider.dart';

 void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFD6D5C9),
      ),
      home: MyHomePage(),
    );
  }
}
