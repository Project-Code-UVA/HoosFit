import 'dart:async';
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
      appBar: buildAppBar(),
      body: Container(
        color: Color(0xFF232D4B),
        child: posts.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      posts[index]['Content'] ?? 'No content',
                      style: TextStyle(color: Color(0xFFC8CBD2)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10),
                        FutureBuilder<Uint8List?>(
                          future: _loadImage(posts[index]['Image']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey, // Placeholder color
                                child: Center(child: Text('Image\nNot\nFound', textAlign: TextAlign.center)),
                              );
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey, // Placeholder color
                                child: Center(child: Text('Error\nLoading\nImage', textAlign: TextAlign.center)),
                              );
                            } else {
                              return Image.memory(
                                snapshot.data!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<Uint8List?> _loadImage(String? base64Image) async {
    if (base64Image != null && base64Image.isNotEmpty) {
      try {
        // Simulate a 20-second delay before loading the image
        await Future.delayed(Duration(seconds: 10));
        return base64Decode(base64Image);
      } catch (e) {
        print('Error decoding image: $e');
      }
    }
    // Return null if base64Image is null or empty
    return null;
  }

  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      title: Text(
        'Feed',
        style: TextStyle(
          color: Color(0xFFF9DCBF),
          fontSize: 18.0 * 1.5,
        ),
      ),
      backgroundColor: Color(0xFFE57200),
      iconTheme: IconThemeData(color: Color(0xFFF9DCBF)),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FeedScreen(),
  ));
}
