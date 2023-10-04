import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/components/textformfield_reusable.dart';
import 'package:twitter_clone/constant/constant.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/screens/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController(text: "phanith1@gmail.com");
  final passwordController = TextEditingController(text: "123123");
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
                  Image.asset(
                    "assets/icons/icons8-lock-100.png",
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 20),
                  const Text('WELCOME TO LOGIN', style: kTitleTextStyle),
                  const SizedBox(height: 20),
                  TextFormFieldReusable(
                    labelText: 'Email',
                    hintText: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    onTab: () {},
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
                                _controller.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            icon: const Icon(Icons.login),
                            label: const Text('Login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: const Text('Sign Up'),
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
