import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superfoods/app/widgets/top_nav_bar.dart';
import '../controllers/home_controller.dart';
import 'list_view.dart'; // This will be your left tab (list view)
import 'map_view.dart'; // This will be your right tab (map view)

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: screenWidth < 600 ? null : TopNavBar(),
      drawer: screenWidth < 600 ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Superfoods',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Suppliers'),
              onTap: () {
                controller.onTabTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: () {
                controller.onTabTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ) : null,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onTabChanged,
        children: [
          const ListViewPage(), // Left tab
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
