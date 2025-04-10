import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpleapp/Post_Service.dart';

//
class AddPostScreen extends StatefulWidget {
 @override
 _AddPostScreenState createState() => _AddPostScreenState();
}


class _AddPostScreenState extends State<AddPostScreen> {
 final TextEditingController _contentController = TextEditingController();
 final PostService _postService = PostService();
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

 Future<void> _addPost(String postText) async {
   // Get the current user ID
   User? user = FirebaseAuth.instance.currentUser;
   if (user == null) {
     print("No user logged in.");
     return;
   }
   String userId = user.uid;
   try{
    await _postService.createPost(postText, userId);
   }catch(e){
    print("error while creating post: $e");
   }
    if (mounted) {
       Navigator.pop(context);
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
               final postText = _contentController.text;
               if (postText.isNotEmpty) {
                 _addPost(postText);
                  
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