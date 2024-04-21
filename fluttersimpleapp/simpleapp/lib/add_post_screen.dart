

import 'dart:convert';
import 'dart:io';




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';




class AddPostScreen extends StatefulWidget {
@override
_AddPostScreenState createState() => _AddPostScreenState();
}




class _AddPostScreenState extends State<AddPostScreen> {
final TextEditingController _contentController = TextEditingController();
File? _imageFile;




Future<void> _addPost(String content) async {
final url = Uri.parse('http://172.26.72.107:3000/api/posts');
final headers = {'Content-Type': 'application/json'};
final body = json.encode({'Content': content});




try {
  final response = await http.post(url, headers: headers, body: body);




  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');




  if (response.statusCode == 201) {
    // Post added successfully
    // You can add additional logic here if needed
    print('Post added successfully');
  } else {
    // Handle error
    print('Failed to add post');
  }
} catch (e) {
 // Handle network or server errors
 print('Error adding post: $e');
 // Print more specific information if available
 if (e is http.ClientException) {
   print('ClientException: ${e.message}');
 } else if (e is SocketException) {
   print('SocketException: ${e.message}');
 } else {
   print('Unknown error type: $e');
 }
}


}








Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.getImage(source: ImageSource.gallery);




  if (pickedImage != null) {
    setState(() {
      _imageFile = File(pickedImage.path);
    });
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
          if (_imageFile != null) ...[
            Image.file(
              _imageFile!,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
          ],
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 16),
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
