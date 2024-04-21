import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class FeedScreen extends StatefulWidget {
 @override
 _FeedScreenState createState() => _FeedScreenState();
}


class _FeedScreenState extends State<FeedScreen> {
 List<Map<String, dynamic>> posts = [];


 @override
 void initState() {
   super.initState();
   fetchPosts();
 }


 Future<void> fetchPosts() async {
   try {
     final dio = Dio();
     final response = await dio.get('http://172.26.72.107:3000/api/posts');


     if (response.statusCode == 200) {
       setState(() {
         posts = List<Map<String, dynamic>>.from(response.data);
       });
     } else {
       // Handle non-200 status code
       print('Failed to fetch posts: ${response.statusCode}');
     }
   } on DioError catch (e) {
     // Handle Dio errors
     if (e.response != null) {
       // The request was made and the server responded with a non-200 status code
       print('DioError response: ${e.response}');
     } else {
       // Something went wrong with the request, such as a network error
       print('DioError request: ${e.requestOptions}');
       print('DioError message: ${e.message}');
     }
   } catch (e) {
     // Handle other errors
     print('Error fetching posts: $e');
   }
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Feed'),
     ),
     body: posts.isEmpty
         ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching posts
         : ListView.builder(
             itemCount: posts.length,
             itemBuilder: (context, index) {
               return ListTile(
                 title: Text(posts[index]['Content'] ?? 'No content'), // Display post content
                 trailing: PopupMenuButton(
                   itemBuilder: (BuildContext context) {
                     return <PopupMenuEntry>[
                       PopupMenuItem(
                         value: 'option1',
                         child: Text('Option 1'),
                       ),
                       PopupMenuItem(
                         value: 'option2',
                         child: Text('Option 2'),
                       ),
                     ];
                   },
                   onSelected: (value) {
                     if (value == 'option1') {
                       // Handle option 1
                     } else if (value == 'option2') {
                       // Handle option 2
                     }
                   },
                 ),
               );
             },
           ),
   );
 }
}
