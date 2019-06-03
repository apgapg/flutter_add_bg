import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_add_bg/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Color(0xff3D5166),
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
