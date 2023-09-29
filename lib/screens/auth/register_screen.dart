import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/components/textformfield_reusable.dart';
import 'package:twitter_clone/constant/constant.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return Stack(
                        children: [
                          _controller.profile != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      FileImage(_controller.profile!),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  child: Text("Profile"),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _controller.pickImage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 15,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldReusable(
                    prefixIcon: Icons.person,
                    labelText: 'Name',
                    hintText: 'Name',
                    controller: nameController,
                    onTab: () {},
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldReusable(
                    prefixIcon: Icons.email,
                    labelText: 'Email',
                    hintText: 'Email',
                    controller: emailController,
                    onTab: () {},
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Email is invalid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldReusable(
                    prefixIcon: Icons.lock,
                    labelText: 'Password',
                    hintText: 'Password',
                    controller: passwordController,
                    onTab: () {},
                    autofocus: true,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton.icon(
                            style: kElevationButtonStyle,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _controller.register(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            icon: const Icon(Icons.login),
                            label: const Text('Resgister'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
