import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  PostService();

  Future<void> createPost(String postText, String userId) async {
    try {
      await _firestore.collection('posts').add({
        'postText': postText,
        'userId': userId,
        'postTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error creating post: $e');
      // Handle the error appropriately, e.g., show a snackbar, log, etc.
      rethrow; // Re-throw the error to be handled further up the call stack
    }
  }

  Stream<QuerySnapshot> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .snapshots();
  }

}