import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/supplier_model.dart';
import '../../../routes/app_pages.dart';

class SupplierPopup extends StatelessWidget {
  final Supplier supplier;

  SupplierPopup({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SUPPLIER, arguments: supplier);
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 150, // Fixed height for a square-ish popup
          child: Row(
            children: [
              // Supplier Image
              Container(
                width: 100,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    supplier.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Supplier Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Supplier Name
                    Text(
                      supplier.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Supplier Type and Specialism
                    Text(
                      '${supplier.type} • ${supplier.specialism}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Supplier Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[700], size: 16),
                        const SizedBox(width: 4),
                        Text('${supplier.rating}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Supplier Tags
                    Expanded(
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: -8.0,
                        children: supplier.tags
                            .map((tag) => Chip(
                                  label: Text(
                                    tag,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.grey[200],
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
