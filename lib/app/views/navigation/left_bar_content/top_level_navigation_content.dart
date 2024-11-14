import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/controllers/layouts/top_bar_controller.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart'; // Import ThemeCustomizer


class TopLevelNavigationContent extends StatelessWidget {
  final bool isCondensed;
  final TopBarController topBarController = Get.put(TopBarController());

  TopLevelNavigationContent({super.key, required this.isCondensed});

  @override
  Widget build(BuildContext context) {
    if (isCondensed) {
      // When the navigation bar is condensed, show only an icon
      return Center(
        child: IconButton(
          icon: Icon(LucideIcons.helpCircle),
          onPressed: () {
            // Expand the navigation bar
            ThemeCustomizer.toggleLeftBarCondensed();
          },
          tooltip: 'Expand Navigation',
        ),
      );
    } else {
      // When the navigation bar is not condensed, show the full content
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adjust padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              Text(
                "Welcome to CO₂ Target Estate Management",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 16),
              // Description
              Text(
                "CO₂ Target is an asset tracking app that allows users to upload details of all energy-using assets, such as lights, boilers, HVAC systems, solar panels, and more. It also enables users to perform peak heat loss calculations and generate Salix applications from the data entered via the tablet app.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 24),
              // Get Started Section
              Text(
                "Get Started",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8),
              // Getting Started Guide Button
              ElevatedButton.icon(
                icon: Icon(LucideIcons.bookOpen),
                label: Text("Read the Getting Started Guide"),
                onPressed: () {
                  // Navigate to the getting started guide
                  Navigator.pushNamed(context, '/getting-started');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              SizedBox(height: 8),
              // Create New Project Button
              ElevatedButton.icon(
                icon: Icon(LucideIcons.plusCircle),
                label: Text("Create a New Project"),
                onPressed: () {
                  // Navigate to create a new project page
                  Navigator.pushNamed(context, '/create-project');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              SizedBox(height: 8),
              // Additional Links or Buttons
              ElevatedButton.icon(
                icon: Icon(LucideIcons.playCircle),
                label: Text("Watch Tutorial Videos"),
                onPressed: () {
                  // Navigate to tutorial videos page
                  Navigator.pushNamed(context, '/tutorial-videos');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              SizedBox(height: 8),
              // Contact Support Button
              OutlinedButton.icon(
                icon: Icon(LucideIcons.helpCircle),
                label: Text("Contact Support"),
                onPressed: () {
                  // Navigate to contact support page
                  Navigator.pushNamed(context, '/contact-support');
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              // Add more buttons or links as needed
            ],
          ),
        ),
      );
    }
  }
}
