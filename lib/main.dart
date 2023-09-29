import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/screens/main_screen.dart';

import 'middleware/main_middleware.dart';
import 'screens/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/main',
          page: () => MainScreen(),
          middlewares: [
            MainMiddleware(),
          ],
        ),
      ],
    );
  }
}
