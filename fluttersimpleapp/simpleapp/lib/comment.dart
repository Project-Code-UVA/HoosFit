import 'package:flutter/material.dart';

class Comment extends StatelessWidget{
    final String text;
    final String userId;
    final String userName;
    final String timeStamp;

    const Comment({super.key, 
      required this.text,
      required this.userId,
      required this.userName,
      required this.timeStamp,
      });

  //Old BUILD METHOD for CONTAINER 
  // @override
  // Widget build(BuildContext context){
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.grey[300],
  //       borderRadius: BorderRadius.circular(4), //Temporary radius and shape for comment
  //     ),
  //     child: Column(
  //       children: [
  //         Text(text),
  //         Row(
  //           children: [
  //             Text(userName),
  //             const Text("-"),
  //             Text(timeStamp),
  //           ],
  //         ),
  //       ],
  //      ), 
  //   );
  // }

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text(text),
      subtitle: Row(
        children: [
          Text(userName),
          const Text(" - "),
          Text(timeStamp),
        ]
      ),
      tileColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      )
    );
  }


}