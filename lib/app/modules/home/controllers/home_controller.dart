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
      phoneNumber: '123-456-7890',
      email: 'contact@oceanfresh.com',
      address: '123 Ocean Drive',
      certifications: ['Certified Organic'],
      awards: ['Best Seafood Supplier 2020'],
      history: 'Established in 1990, Ocean Fresh Seafood has been providing...',
      mission: 'To provide the freshest seafood...',
      userGeneratedContent: ['Customer reviews and photos...', 'Number 2', 'Number 3'],
      hasLiveChat: true,
      hasCalendar: true,
      hasSampleRequest: true,
      hasQuoteRequest: true,
      hasLoyaltyProgram: true,
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
      phoneNumber: '987-654-3210',
      email: 'info@greenvalleyfarms.com',
      address: '456 Green Road',
      certifications: ['Certified Organic', 'Non-GMO'],
      awards: ['Best Local Farm 2019'],
      history: 'Green Valley Farms has been family-owned since 1985...',
      mission: 'To grow the healthiest vegetables...',
      userGeneratedContent: ['Customer testimonials and recipes...', 'Numner 2', 'Number 3'],
      hasLiveChat: true,
      hasCalendar: true,
      hasSampleRequest: true,
      hasQuoteRequest: true,
      hasLoyaltyProgram: true,
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
      phoneNumber: '555-555-5555',
      email: 'support@butchersbest.com',
      address: '789 Meat Street',
      certifications: ['Certified Humane'],
      awards: ['Top Butcher Shop 2018'],
      history: 'Butcher\'s Best started as a small shop in 2000...',
      mission: 'To provide the best quality meat...',
      userGeneratedContent: ['Customer reviews and photos...', 'Number 2', 'Number 3'],
      hasLiveChat: true,
      hasCalendar: true,
      hasSampleRequest: true,
      hasQuoteRequest: true,
      hasLoyaltyProgram: true,
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
