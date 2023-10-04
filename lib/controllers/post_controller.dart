import 'package:get/get.dart';
import 'package:twitter_clone/services/api_helper.dart';
import 'dart:io';

class PostController extends GetxController {
  final _api = APIHelper();

  void post({required String caption, File? photo}) async {
    try {
      final success = await _api.createPost(caption: caption, photo: photo);
      if (success) {
        Get.back(result: true);
      } else {
        Get.snackbar("Error", "Failed to create post");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
