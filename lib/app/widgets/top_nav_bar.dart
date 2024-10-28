import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  TopNavBar({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make the navbar responsive
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Site Logo and Name
              Row(
                children: [
                  // Logo Image
                  Image.asset(
                    'assets/logo.png',
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  // Site Name
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
              const Spacer(),
              // Drawer Icon
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        backgroundColor: Colors.blueGrey[900],
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Site Logo and Name
              Row(
                children: [
                  // Logo Image
                  Image.asset(
                    'assets/logo.png', // Replace with your logo asset path
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  // Site Name
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
              const SizedBox(width: 32),
              // Super Search Bar
              Expanded(
                child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      hintText: 'Search suppliers or food types...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              // Quick Links
              Row(
                children: [
                  _NavBarItem(
                    title: 'Orders',
                    onTap: () {
                      // Navigate to Orders page
                    },
                  ),
                  const SizedBox(width: 16),
                  _NavBarItem(
                    title: 'Favorites',
                    onTap: () {
                      // Navigate to Favorites page
                    },
                  ),
                  const SizedBox(width: 16),
                  _NavBarItem(
                    title: 'Help',
                    onTap: () {
                      // Navigate to Help page
                    },
                  ),
                ],
              ),
              const SizedBox(width: 32),
              // Icons
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Notifications action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.brightness_6, color: Colors.white),
                    onPressed: () {
                      // Toggle light/dark mode
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      // Account action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
