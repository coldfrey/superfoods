import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/supplier_controller.dart';
import '../../../widgets/top_nav_bar.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            // Supplier Overview
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Supplier Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        controller.supplier.imageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Supplier Name
                  Text(
                    controller.supplier.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Supplier Type and Specialism
                  Text(
                    '${controller.supplier.type} • ${controller.supplier.specialism}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Supplier Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      const SizedBox(width: 4),
                      Text('${controller.supplier.rating}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Supplier Contact Information
                  Text(
                    'Contact Information',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Phone: ${controller.supplier.phoneNumber}'),
                  Text('Email: ${controller.supplier.email}'),
                  Text('Address: ${controller.supplier.address}'),
                  const SizedBox(height: 16),
                  // Supplier Certifications and Awards
                  Text(
                    'Certifications and Awards',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4.0,
                    children: controller.supplier.certifications
                        .map((certification) => Chip(
                              label: Text(certification),
                              backgroundColor: Colors.grey[200],
                            ))
                        .toList(),
                  ),
                  Wrap(
                    spacing: 4.0,
                    children: controller.supplier.awards
                        .map((award) => Chip(
                              label: Text(award),
                              backgroundColor: Colors.grey[200],
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Supplier History and Mission
                  Text(
                    'History and Mission',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(controller.supplier.history),
                  const SizedBox(height: 8),
                  Text(controller.supplier.mission),
                ],
              ),
            ),
            // Tabs for Catalog, Reviews/Ratings, Pictures, User-Generated Content, and Interactive Elements
            TabBar(
              tabs: [
                Tab(text: 'Catalog'),
                Tab(text: 'Reviews/Ratings'),
                Tab(text: 'Pictures'),
                Tab(text: 'User-Generated Content'),
                Tab(text: 'Interactive Elements'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Catalog Tab
                  Center(child: Text('Catalog')),
                  // Reviews/Ratings Tab
                  Center(child: Text('Reviews/Ratings')),
                  // Pictures Tab
                  Center(child: Text('Pictures')),
                  // User-Generated Content Tab
                  Center(child: Text('User-Generated Content')),
                  // Interactive Elements Tab
                  Center(child: Text('Interactive Elements')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
