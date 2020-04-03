import 'package:flutter/material.dart';

import './screens/main-view-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'some title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainViewScreen(),
    );
  }
}
