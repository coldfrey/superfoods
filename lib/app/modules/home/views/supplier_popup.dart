// app/modules/home/views/supplier_popup.dart

import 'package:flutter/material.dart';
import '../../../data/models/supplier_model.dart';

class SupplierPopup extends StatelessWidget {
  final Supplier supplier;

  SupplierPopup({required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(12),
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
            SizedBox(width: 12),
            // Supplier Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Supplier Name
                  Text(
                    supplier.name,
                    style: TextStyle(
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
                  SizedBox(height: 4),
                  // Supplier Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 16),
                      SizedBox(width: 4),
                      Text('${supplier.rating}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Supplier Tags
                  Expanded(
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: -8.0,
                      children: supplier.tags
                          .map((tag) => Chip(
                                label: Text(
                                  tag,
                                  style: TextStyle(fontSize: 12),
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
    );
  }
}
