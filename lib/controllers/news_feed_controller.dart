import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:twitter_clone/screens/main/post_screen.dart';

import '../models/post_res_model.dart';
import '../services/api_helper.dart';

class NewsFeedController extends GetxController {
  final _imagePicker = ImagePicker();
  final _api = APIHelper();

  @override
  void onInit() {
    getAllPost();
    super.onInit();
  }

  File? photo;
  PostResModel posts = PostResModel();
  void pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    photo = File(pickedFile.path);
    final data = await Get.to(
      () => PostScreen(
        photo: photo!,
      ),
    );
    if (data != null) {
      getAllPost();
    }
    // update();
  }

  void getAllPost() async {
    try {
      final res = await _api.getAllPosts();
      posts = res;
      print("Refresh data");
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void likeDisLike(int postId) async {
    try {
      final res = await _api.likeDisLike(postId);
      print("likeDisLike $res");

      /// find the post index
      final index = posts.data!.indexWhere((element) => element.id == postId);

      /// update liked status
      posts.data![index].liked = !posts.data![index].liked!;
      // update like count
      if (posts.data![index].liked!) {
        posts.data![index].likesCount = posts.data![index].likesCount! + 1;
      } else {
        posts.data![index].likesCount = posts.data![index].likesCount! - 1;
      }
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
