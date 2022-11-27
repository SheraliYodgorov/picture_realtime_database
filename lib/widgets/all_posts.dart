// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picture_rtdb/models/post_model.dart';
import 'package:picture_rtdb/services/rtdb_service.dart';
import 'package:picture_rtdb/widgets/create_post.dart';
import 'package:picture_rtdb/widgets/list_item.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  List<PostModel> posts = [];

  void onPostAdded(PostModel post) {
    setState(() {
      posts.add(post);
    });
  }

  @override
  void initState() {
    DBService.getPost(onPostAdded);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: buildAppbar(),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //   final id = DateTime.now().microsecondsSinceEpoch.toString();
          //   print('DBService: buildButton: => $id');
          //   DBService.setPost(PostModel(id: id, ));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePost(),
              ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text('All Posts'),
    );
  }

  buildBody() {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListItem(
          firstname: post.firstname ?? 'NO firstname',
          lastname: post.lastname ?? 'No lastname',
          content: post.content ?? 'No content',
          data: post.data ?? 'No data',
          image: post.image,
        );
        // : const Center(
        //     child: CircularProgressIndicator.adaptive(),
        //   );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 0,
        );
      },
    );
  }
}
  // buildButton(Function onPressed) {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       final id = DateTime.now().microsecondsSinceEpoch.toString();
  //       print('DBService: buildButton: => $id');
  //       DBService.setPost(PostModel(id: '1', firstname: 'edqw'));
  //       onPressed;
  //     },
  //     child: const Icon(CupertinoIcons.add),
  //   );
  // }
