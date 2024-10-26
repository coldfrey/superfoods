import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superfoods/app/data/models/supplier_model.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  final pageController = PageController();

   var suppliers = <Supplier>[
    Supplier(
      name: 'Ocean Fresh Seafood',
      imageUrl: 'https://via.placeholder.com/80',
      rating: 4.5,
      type: 'Wholesale',
      specialism: 'Fish',
      tags: ['Organic', 'Locally Sourced'],
      latitude: 37.7749, // Example coordinates
      longitude: -122.4194,
    ),
    Supplier(
      name: 'Green Valley Farms',
      imageUrl: 'https://via.placeholder.com/80',
      rating: 4.8,
      type: 'Local Business',
      specialism: 'Vegetables',
      tags: ['Organic', 'Free Range'],
      latitude: 37.7849,
      longitude: -122.4094,
    ),
    Supplier(
      name: 'Butcher\'s Best',
      imageUrl: 'https://via.placeholder.com/80',
      rating: 4.2,
      type: 'Restaurant',
      specialism: 'Meat',
      tags: ['Free Range', 'Grass Fed'],
      latitude: 37.7649,
      longitude: -122.4294,
    ),
  ].obs;

  void onTabTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onTabChanged(int index) {
    selectedIndex.value = index;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
