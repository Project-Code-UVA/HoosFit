import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  File? _imageFile;

  Future<void> _addPost(String content) async {
    final url = Uri.parse('http://172.26.72.107:3000/api/posts');
    final headers = {'Content-Type': 'multipart/form-data'};
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);
    request.fields['Content'] = content;

final mimeType = lookupMimeType(_imageFile!.path, headerBytes: [0xFF, 0xD8]);
if (mimeType != null) {
  final mimeTypeParts = mimeType.split('/');
  if (mimeTypeParts.length == 2) {
    final file = await http.MultipartFile.fromPath(
      'image',
      _imageFile!.path,
      contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
    );
    request.files.add(file);
  } else {
    print('Invalid MIME type format');
  }
} else {
  print('Failed to determine MIME type');
}

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Post added successfully');
        // Handle success, navigate to another screen, etc.
      } else {
        print('Failed to add post');
        // Handle failure
      }
    } catch (e) {
      print('Error adding post: $e');
      // Handle error
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

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
