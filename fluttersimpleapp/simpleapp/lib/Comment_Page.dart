import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'comment.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: comment_page(),
    );
  }
}

class comment_page extends StatefulWidget{
  const comment_page({super.key});

   @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<comment_page> {
  late Future <Map<String, dynamic>> comments; 
  final commentTextController = TextEditingController();


  void addComment(String comment){

  }

  void deleteComment(){

  }


  //Used for when Comment Button is pressed
  void showDialogBox(){
    showDialog(context: context,
     builder: (context) => AlertDialog(
      title: const Text("Add Comment"),
      content: TextField(
        controller: commentTextController,
      ),
      actions: [
        TextButton(
          onPressed: () => addComment(commentTextController.text),
          child: const Text("Post")
         ),

        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel")
         ),
      ]
     )
    );
  }

//Has to be implemented using http request for comments for given post 
  Future<List<Map<String, dynamic>>> fetchComments() async {
    //TODO: Use actual API Endpoint here
  final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((comment) => {
     'text': comment['text'],
      'userId': comment['userId'],
      'userName': comment['userName'],
      'timeStamp': comment['timeStamp'], 
      }).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  
  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchComments(),
       builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }else {
          List<Map<String, dynamic>> comments = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: const Text("Comments"),
            ),
          body: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> comment = comments[index];
            return Comment(
                  text: comment['text'],
                  userId: comment['userId'],
                  userName: comment['userName'],
                  timeStamp: comment['timeStamp'],
                ); 
            },
          ),
          floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Call the addComment method to add a new comment
            addComment();
          },
          child: const Icon(Icons.add),
       ),
      );    
     }
    }
  );
}


}