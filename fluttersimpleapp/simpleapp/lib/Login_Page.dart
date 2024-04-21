import 'package:flutter/material.dart';
import 'home_screen.dart';


class LoginPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Login'),
     ),
     body: Padding(
       padding: EdgeInsets.all(16.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           TextField(
             decoration: InputDecoration(
               labelText: 'Email',
             ),
           ),
           SizedBox(height: 16.0),
           TextField(
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Password',
             ),
           ),
           SizedBox(height: 16.0),
           ElevatedButton(
             onPressed: () {
               // Perform login authentication here
               // For now, navigate to HomeScreen on successful login
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => HomeScreen()),
               );
             },
             child: Text('Login'),
           ),
         ],
       ),
     ),
   );
 }
}



