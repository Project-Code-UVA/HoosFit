import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      final uri = Uri.parse('http://172.26.72.107:3000/api/posts'); // Replace with your server URL
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        setState(() {
          final List<dynamic> decodedPosts = jsonDecode(response.body);
          posts = decodedPosts.map((post) {
            final String content = post['Content'] != null ? post['Content'] : 'No content';
            final String base64Image = post['Image'] != null ? post['Image'] : ''; // Handle null case for image
            return {
              'Content': content,
              'Image': base64Image,
            };
          }).toList();
        });
      } else {
        print('Failed to fetch posts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // Use the custom app bar
      body: Container(
        color: Color(0xFF232D4B), // UVA Blue for background color
        child: posts.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching posts
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      posts[index]['Content'] ?? 'No content',
                      style: TextStyle(color: Color(0xFFC8CBD2)), // UVA Blue 25% for post text color
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10), // Adjust the spacing between text and image
                        Image.memory(
                          base64Decode(posts[index]['Image']), // Decode base64 string to Uint8List
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      title: Text(
        'Feed',
        style: TextStyle(
          color: Color(0xFFF9DCBF), // UVA Orange 25% for app bar text color
          fontSize: 18.0 * 1.5, // Set app bar font size to 18 * 1.5
        ),
      ),
      backgroundColor: Color(0xFFE57200), // UVA Orange for app bar background color
      iconTheme: IconThemeData(color: Color(0xFFF9DCBF)), // Set arrow icon color to UVA Orange 25%
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FeedScreen(),
  ));
}
