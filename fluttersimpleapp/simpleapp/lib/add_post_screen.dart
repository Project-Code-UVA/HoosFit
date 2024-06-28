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
   final Color uvaBlue = Color(0xFF232D4B); // Define the UVA Blue color
   final Color uvaBlue25 = Color(0xFFC8CBD2); // Define the UVA Blue 25% color
   final Color uvaOrange = Color(0xFFE57200); // Define the UVA Orange color
   final Color uvaOrange25 = Color(0xFFF9DCBF); // Define the UVA Orange 25% color


   return Scaffold(
     appBar: AppBar(
       title: Text(
         'Add Post',
         style: TextStyle(
           color: uvaOrange25, // Set app bar title text color to UVA Orange 25%
           fontSize: 18.0 * 1.5, // Set app bar title font size to 18 * 1.5
         ),
       ),
       backgroundColor: uvaOrange, // Set app bar background color to UVA Orange
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         color: uvaOrange25, // Set back arrow color to UVA Orange 25%
         onPressed: () {
           Navigator.pop(context); // Navigate back to the previous screen (HomeScreen)
         },
       ),
     ),
     backgroundColor: uvaBlue, // Set background color to UVA Blue
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
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(uvaOrange), // Set button background color to UVA Orange
               foregroundColor: MaterialStateProperty.all<Color>(uvaOrange25), // Set button text color to UVA Orange 25%
               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 32, vertical: 16)), // Set button padding to make it longer
             ),
             child: Text('Pick Image', style: TextStyle(color: uvaOrange25, fontSize: 16)), // Set button text color to UVA Orange 25% and font size to 16
           ),
           SizedBox(height: 16),
           TextField(
             controller: _contentController,
             decoration: InputDecoration(
               labelText: 'Enter post content',
               labelStyle: TextStyle(color: uvaBlue25, fontSize: 16), // Set text input label color to UVA Blue 25% and font size to 16
             ),
             style: TextStyle(color: uvaBlue25, fontSize: 16), // Set text input color to UVA Blue 25% and font size to 16
           ),
           SizedBox(height: 16),
           ElevatedButton(
             onPressed: () {
               final content = _contentController.text;
               if (content.isNotEmpty) {
                 _addPost(content, _imageFile);
                 Navigator.pop(context); // Close the screen after adding the post
               }
             },
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all<Color>(uvaOrange), // Set button background color to UVA Orange
               foregroundColor: MaterialStateProperty.all<Color>(uvaOrange25), // Set button text color to UVA Orange 25%
               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 32, vertical: 16)), // Set button padding to make it longer
             ),
             child: Text('Add Post', style: TextStyle(color: uvaOrange25, fontSize: 16)), // Set button text color to UVA Orange 25% and font size to 16
  ),
       ],
     ),
   ),
 );
}
}





