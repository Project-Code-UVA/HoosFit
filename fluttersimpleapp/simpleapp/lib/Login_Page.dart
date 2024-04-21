import 'package:flutter/material.dart';
import 'home_screen.dart';


class LoginPage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xFFE57200),
       title: Text(
         'Login',
         style: TextStyle(
           fontFamily: 'Teko',
           fontSize: 18.0 * 1.5, // Increased font size by 1.5 times
           color: Color(0xFFF9DCBF), // Set text color to HEX #C8CBD2 (UVA Blue 25%)
         ),
       ),
     ),
     backgroundColor: Color(0xFF232D4B), // Set background color to HEX #232D4B (UVA Blue)
     body: Padding(
       padding: EdgeInsets.all(16.0 * 1.5), // Increased padding by 1.5 times
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           TextField(
             decoration: InputDecoration(
               labelText: 'Email',
               labelStyle: TextStyle(
                 fontFamily: 'Teko',
                 fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                 color: Color(0xFFC8CBD2), // Set label text color to HEX #C8CBD2 (UVA Blue 25%)
               ),
             ),
           ),
           SizedBox(height: 16.0 * 1.5), // Increased sized box height by 1.5 times
           TextField(
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Password',
               labelStyle: TextStyle(
                 fontFamily: 'Teko',
                 fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                 color: Color(0xFFC8CBD2), // Set label text color to HEX #C8CBD2 (UVA Blue 25%)
               ),
             ),
           ),
           SizedBox(height: 16.0 * 1.5), // Increased sized box height by 1.5 times
           ElevatedButton(
             onPressed: () {
               // Perform login authentication here
               // For now, navigate to HomeScreen on successful login
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => HomeScreen()),
               );
             },
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE57200)), // Set button background color to HEX #E57200 (UVA Orange)
             ),
             child: Text(
               'Login',
               style: TextStyle(
                 fontFamily: 'Teko',
                 fontSize: 16.0 * 1.5, // Increased font size by 1.5 times
                 color: Color(0xFFF9DCBF), // Set button text color to HEX #F9DCBF (UVA Orange 25%)
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}
