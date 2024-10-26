// app/data/models/supplier_model.dart

class Supplier {
  final String name;
  final String imageUrl;
  final double rating;
  final String type;
  final String specialism;
  final List<String> tags;
  final double latitude;
  final double longitude;

  Supplier({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.type,
    required this.specialism,
    required this.tags,
    required this.latitude,
    required this.longitude,
  });
}
