import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picture_rtdb/models/post_model.dart';
import 'package:picture_rtdb/services/rtdb_service.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});
  

  @override
  State<CreatePost> createState() => _CreatePostState();
  
}


class _CreatePostState extends State<CreatePost> {
  
  final firstnameCtrl = TextEditingController();
  final lastnameCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final validator = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? file;
  CreatePostState state = CreatePostState.initial;
  

  @override
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Create Post'),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: SingleChildScrollView(
        child: Form(
          key: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPicture(),
              buildTextField('Firstname', firstnameCtrl, validator: (value) {
                return value?.isNotEmpty == true ? null : 'Title mus be felled';
              }),
              const SizedBox(height: 4),
              buildTextField('Lastname', lastnameCtrl, validator: (value) {
                return value?.isNotEmpty == true ? null : 'Title mus be felled';
              }),
              const SizedBox(height: 4),
              buildTextField('Content', contentCtrl, validator: (value) {
                return value?.isNotEmpty == true ? null : 'Title mus be felled';
              }),
              const SizedBox(height: 4),
              buildTextField('Date', dateCtrl, validator: (value) {
                return value?.isNotEmpty == true ? null : 'Title mus be felled';
              }),
              const SizedBox(height: 12),
              buildButton(state == CreatePostState.loading
                  ? null
                  : () async {
                      if (validator.currentState!.validate()) {
                        setState(() {
                          state == CreatePostState.loading;
                        });
                        final post = PostModel(
                          id: DateTime.now().microsecondsSinceEpoch.toString(),
                          firstname: firstnameCtrl.text,
                          lastname: lastnameCtrl.text,
                          content: contentCtrl.text,
                          data: dateCtrl.text,
                        );
                        final res = await DBService.setPost(post, file);
                        if (res) {
                          setState(() {
                            state = CreatePostState.loaded;
                          });
                        }
                      }
                    })
            ],
          ),
        ),
      ),
    );
  }

  buildTextField(String label, TextEditingController controller,
      {String? Function(String? value)? validator}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  buildButton(VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(44)),
      child: const Text('Add'),
    );
  }

  buildPicture() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final result = await picker.pickImage(source: ImageSource.gallery);
          if (result?.path != null) {
            setState(() {
              file = File(result!.path);
            });
          }
        },
        child: Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          child: ClipRRect(
            child: file != null
                ? Image.file(
                    file!,
                  )
                : Image.asset(
                    'assets/images/placeholder1.jpg',
                  ),
          ),
        ),
      ),
    );
  }
}

enum CreatePostState {
  initial,
  loading,
  loaded,
  error,
}
