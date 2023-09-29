import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(
        builder: (_) {
          switch (_controller.currentIndex) {
            case 0:
              return _controller.lstScreens[_controller.currentIndex];
              break;
            case 1:
              return _controller.lstScreens[_controller.currentIndex];

              break;
            case 2:
              return _controller.lstScreens[_controller.currentIndex];

              break;
            case 3:
              return _controller.lstScreens[_controller.currentIndex];
              break;
            default:
              return Container(
                child: Center(
                  child: Text("News Feed Screen"),
                ),
              );
          }
        },
      ),
      bottomNavigationBar: GetBuilder<MainController>(builder: (_) {
        return BottomNavigationBar(
          currentIndex: _controller.currentIndex,
          onTap: (index) {
            _controller.currentIndex = index;
            _controller.update();
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: "News feed",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        );
      }),
    );
  }
}
