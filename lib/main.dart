import 'package:flutter/material.dart';
import 'NoticeList.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter News',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new NoticeList(),
    );
  }

}