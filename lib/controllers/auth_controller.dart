import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:quickalert/quickalert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/screens/main_screen.dart';
import 'package:twitter_clone/services/api_helper.dart';

class AuthController extends GetxController {
  File? profile;
  final _imagePicker = ImagePicker();
  final _apiHelper = APIHelper();
  final box = GetStorage();

  void setProfile(File? file) {
    profile = file;
    update();
  }

  void pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setProfile(File(pickedFile.path)); //convert xFile to File
  }

  void register(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final success = await _apiHelper.register(
        email: email,
        name: name,
        password: password,
        profile: profile,
      );
      if (success) {
        QuickAlert.show(
          barrierDismissible: false,
          context: Get.context!,
          type: QuickAlertType.success,
          text: 'Register success!',
          onConfirmBtnTap: () {
            Get.back();
            Get.back();

            /// go back to login screen
          },
        );
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          text: 'Register failed!',
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: e.toString(),
      );
    }
  }

  void login({required String email, required String password}) async {
    try {
      final user = await _apiHelper.login(email: email, password: password);
      if (user != null) {
        box.write("token", user.token);
        // save token to local storage
        /// bring user to home screen
        Get.offAll(() => MainScreen());
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          text: 'Login failed!',
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: e.toString(),
      );
    }
  }
}
