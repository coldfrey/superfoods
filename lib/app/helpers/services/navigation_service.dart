import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  static BuildContext? globalContext;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Save the current route to local storage
  static Future<void> _saveLastRoute(String routeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Saving last route: $routeName');
    await prefs.setString('lastRoute', routeName);
  }

  // Get the last saved route from local storage
  static Future<String?> getLastRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('Getting last route');
    return prefs.getString('lastRoute');
  }

  static void registerContext(BuildContext context, {bool update = false}) {
    if (globalContext == null || update) {
      globalContext = context;
    }
  }

  // Navigate to the route and save it to local storage
  static void toNamed(String routeName) {
    if (routeName.contains('null')) return;
    Get.toNamed(routeName);
    _saveLastRoute(routeName); // Save route on navigation
  }

  // Navigate to the last saved route, or default route if none saved
  static Future<void> navigateToLastRoute({String defaultRoute = '/'}) async {
    String? lastRoute = await getLastRoute();
    if (lastRoute != null && lastRoute.isNotEmpty) {
      // print('Navigating to last route: $lastRoute');
      toNamed(lastRoute);
    } else {
      toNamed(defaultRoute); // Fallback to default route
    }
  }

  static void goBack() {
    Get.back();
  }
}
