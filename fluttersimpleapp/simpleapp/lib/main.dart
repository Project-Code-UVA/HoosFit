// main.dart
import 'package:flutter/material.dart';
import 'package:simpleapp/Login_Page.dart';
import 'home_screen.dart';
import 'health.dart';


void main() {
 runApp(MyApp());
}


class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'HoosFit',
     theme: ThemeData(
      
       fontFamily: 'Teko',
       primaryColor: Color(0xFFE57200),
     ),
     home: LoginPage(),
   );
 }
}
