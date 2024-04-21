import 'package:flutter/material.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart'; // Import the FeedScreen
import 'login_page.dart'; // Import the LoginPage


class HomeScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   final double buttonWidth = MediaQuery.of(context).size.width * 0.7; // Set the desired button width


   final Color uvaBlue25 = Color(0xFFC8CBD2); // Define the UVA Blue 25% color
   final Color uvaOrange = Color(0xFFE57200); // Define the UVA Orange color
   final Color uvaOrange25 = Color(0xFFF9DCBF); // Define the UVA Orange 25% color


   return Scaffold(
     appBar: AppBar(
       title: Text(
         'Home',
         style: TextStyle(
           color: uvaOrange25,
           fontSize: 18.0 * 1.5, // Set app bar title font size to 18 * 1.5
         ),
       ),
       backgroundColor: uvaOrange, // Set app bar background color to UVA Orange
     ),
     backgroundColor: Color(0xFF232D4B), // Set background color to UVA Blue
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           ElevatedButton(
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => AddPostScreen()),
               );
             },
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(uvaOrange), // Set button background color to UVA Orange
               foregroundColor: MaterialStateProperty.all<Color>(uvaOrange25), // Set button text color to UVA Orange 25%
               textStyle: MaterialStateProperty.all<TextStyle>(
                 TextStyle(
                   fontFamily: 'Teko', // Set button font family to Teko
                   fontSize: 16.0, // Set button font size
                 ),
               ),
               minimumSize: MaterialStateProperty.all<Size>(Size(buttonWidth, 40.0)), // Set button width and height
             ),
             child: Text('Add Post'),
           ),
           SizedBox(height: 16.0),
           ElevatedButton(
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => FeedScreen()), // Navigate to FeedScreen
               );
             },
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(uvaOrange), // Set button background color to UVA Orange
               foregroundColor: MaterialStateProperty.all<Color>(uvaOrange25), // Set button text color to UVA Orange 25%
               textStyle: MaterialStateProperty.all<TextStyle>(
                 TextStyle(
                   fontFamily: 'Teko', // Set button font family to Teko
                   fontSize: 16.0, // Set button font size
                 ),
               ),
               minimumSize: MaterialStateProperty.all<Size>(Size(buttonWidth, 40.0)), // Set button width and height
             ),
             child: Text('View Feed'),
           ),
           SizedBox(height: 16.0),
           ElevatedButton(
             onPressed: () {
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
               );
             },
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(uvaOrange), // Set button background color to UVA Orange
               foregroundColor: MaterialStateProperty.all<Color>(uvaOrange25), // Set button text color to UVA Orange 25%
               textStyle: MaterialStateProperty.all<TextStyle>(
                 TextStyle(
                   fontFamily: 'Teko', // Set button font family to Teko
                   fontSize: 16.0, // Set button font size
                 ),
               ),
               minimumSize: MaterialStateProperty.all<Size>(Size(buttonWidth, 40.0)), // Set button width and height
             ),
             child: Text('Sign Out'),
           ),
         ],
       ),
     ),
   );
 }
}



