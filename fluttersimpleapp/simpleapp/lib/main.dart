// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simpleapp/home_screen.dart';
import 'package:simpleapp/Login_Page.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
   
   Widget home;
    if (FirebaseAuth.instance.currentUser != null) {
      home = HomeScreen(); // User is logged in, go to home screen
    } else {
      home = LoginPage(); // User is not logged in, go to login page
    }




   return MaterialApp(
     title: 'HoosFit',
     theme: ThemeData(
      
       fontFamily: 'Teko',
       primaryColor: Color(0xFFE57200),
     ),
     home: home,
   );
 }
}
