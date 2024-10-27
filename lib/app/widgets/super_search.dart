// app/widgets/super_search_widget.dart

import 'package:flutter/material.dart';

class SuperSearchWidget extends StatefulWidget {
  @override
  _SuperSearchWidgetState createState() => _SuperSearchWidgetState();
}

class _SuperSearchWidgetState extends State<SuperSearchWidget> {
  bool _isExpanded = false;
  double _searchRadius = 10; // Default radius in kilometers
  Map<String, bool> _filters = {
    'Organic': false,
    'Free Range': false,
    'Locally Sourced': false,
    'Vegan': false,
    'Gluten Free': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar and Filter Button
        Row(
          children: [
            // Search Bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search suppliers or food types...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(width: 8),
            // Filter Button
            IconButton(
              icon: Icon(
                _isExpanded ? Icons.filter_alt_off : Icons.filter_alt,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ],
        ),
        // Expanded Filters Section
        if (_isExpanded)
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                // Search Radius Slider
                Row(
                  children: [
                    Text(
                      'Search Radius:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text('${_searchRadius.round()} km'),
                  ],
                ),
                Slider(
                  value: _searchRadius,
                  min: 1,
                  max: 100,
                  divisions: 99,
                  label: '${_searchRadius.round()} km',
                  onChanged: (value) {
                    setState(() {
                      _searchRadius = value;
                    });
                  },
                ),
                Divider(),
                // Filter Checkboxes
                Column(
                  children: _filters.keys.map((String key) {
                    return CheckboxListTile(
                      title: Text(key),
                      value: _filters[key],
                      onChanged: (bool? value) {
                        setState(() {
                          _filters[key] = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
