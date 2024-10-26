import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'list_view.dart'; // This will be your left tab (list view)
import 'map_view.dart'; // This will be your right tab (map view)

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superfoods'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onTabChanged,
        children: [
          ListViewPage(), // Left tab
          MapViewPage(), // Right tab
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onTabTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Suppliers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
            ],
          )),
    );
  }
}
