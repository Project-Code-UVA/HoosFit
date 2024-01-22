import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPostScreen extends StatelessWidget {
  final TextEditingController _contentController = TextEditingController();

  Future<void> _addPost(String content) async {
    final response = await http.post(
      Uri.parse('http://172.26.82.72:3000/api/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'Content': content}),
    );

    if (response.statusCode == 201) {
      // Post added successfully
      // You can add additional logic here if needed
      print('Post added successfully');
    } else {
      // Handle error
      print('Failed to add post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Enter post content'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final content = _contentController.text;
                if (content.isNotEmpty) {
                  _addPost(content);
                  Navigator.pop(context); // Close the screen after adding the post
                }
              },
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
