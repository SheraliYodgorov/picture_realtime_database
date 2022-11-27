// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:picture_rtdb/models/post_model.dart';

class DBService {
  static final FirebaseDatabase db = FirebaseDatabase.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> getPost(Function(PostModel) onAdded) async {
    final ref = db.ref('posts');

    ref.onChildAdded.listen((event) {
     
      if (event.snapshot.exists) {
        final post = PostModel.fromJson(
          Map<String, dynamic>.from(
            event.snapshot.value as Map,
          ),
        );
        onAdded(post);
      }
    });
  }

  static Future<bool> setPost(PostModel post, File? file) async {
    final ref = db.ref('posts/${post.id}');
    try {
      TaskSnapshot? res;
      if (file != null) {
        res = await storage
            .ref('posts')
            .child(file.path.split('/').last)
            .putFile(file);
      }
      post.image = await res?.ref.getDownloadURL();
      print("DBService: setPost: image ref => ${post.image}");
      await ref.set(post.toJson());
    } catch (e) {
      print('DBService: setPost: error => $e');
      return false;
    }
    return true;
  }
}
