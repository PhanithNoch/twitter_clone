import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:twitter_clone/controllers/post_controller.dart';

class PostScreen extends StatelessWidget {
  final _controller = Get.put(PostController());
  final _captionController = TextEditingController();
  final File photo;
  PostScreen({required this.photo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          TextButton(
            onPressed: () {
              print("photo $photo");
              _controller.post(
                caption: _captionController.text,
                photo: photo,
              );
            },
            child: const Text(
              "Post",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  child: Text("A"),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      hintText: "Caption",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.file(photo),
        ],
      ),
    );
  }
}
