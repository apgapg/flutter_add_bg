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
      theme: ThemeData(primarySwatch: Colors.pink, fontFamily: 'Nunito', scaffoldBackgroundColor: Color(0xfff8f8ff)),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
