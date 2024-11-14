import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Observable variable to hold the current route
  var currentRoute = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to route changes
    ever(currentRoute, (String route) {
      // You can perform additional actions here if needed
      print('Current Route: $route');
    });
  }

  // Method to update the current route
  void updateRoute(String? route) {
    if (route != null) currentRoute.value = route;
  }
}
