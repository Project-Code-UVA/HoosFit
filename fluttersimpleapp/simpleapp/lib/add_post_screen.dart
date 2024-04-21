import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _addPost(String? content, File? imageFile) async {
    try {
      if (content == null || content.isEmpty) {
        print('Content cannot be empty');
        return;
      }

      final dio = Dio();
      final formData = FormData.fromMap({
        'content': content,
        'image': imageFile != null ? await MultipartFile.fromFile(imageFile.path) : null,
      });

      final response = await dio.post(
        'http://172.26.72.107:3000/api/upload', // Replace with your server URL
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 201) {
        print('Post added successfully');
        // Handle success, navigate to another screen, etc.
      } else {
        print('Failed to add post');
        // Handle failure
      }
    } on DioError catch (e) {
      print('DioError adding post: $e');
      // Handle Dio error
    } catch (e) {
      print('Error adding post: $e');
      // Handle other errors
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
                final imageFile = _imageFile;
                _addPost(content, imageFile);
                Navigator.pop(context); // Close the screen after adding the post
              },
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
