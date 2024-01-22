// home_screen.dart
import 'package:flutter/material.dart';
import 'add_post_screen.dart';
import 'feed_screen.dart'; // Import the FeedScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
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
              child: Text('View Feed'),
            ),
          ],
        ),
      ),
    );
  }
}
