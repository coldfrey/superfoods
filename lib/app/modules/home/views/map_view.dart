import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../controllers/home_controller.dart';
import '../../../data/models/supplier_model.dart';
import 'supplier_popup.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(0, 0);
  BitmapDescriptor? _locationIcon;
  final HomeController _homeController = Get.find<HomeController>();
  Supplier? _selectedSupplier;

  // Map style to hide points of interest, transit, and other map labels
  final String _mapStyle = '''
  [
    {
      "featureType": "poi",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
    _createLocationIcon(); // Create custom location icon
    _getUserLocation();
  }

  Future<void> _createLocationIcon() async {
    // Create custom icon for user location
    _locationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(25, 25)),
      'assets/blue_circle_icon.png',
    );
  }

  Future<void> _getUserLocation() async {
    // Get user's current location
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      setState(() {
        _initialPosition = currentLocation;
      });

      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 15),
      );
    } catch (e) {
      print("Error retrieving location: $e");
    }
  }

  Set<Marker> _createMarkers() {
    final markers = <Marker>{};

    // Add supplier markers
    for (var supplier in _homeController.suppliers) {
      markers.add(
        Marker(
          markerId: MarkerId(supplier.name),
          position: LatLng(supplier.latitude, supplier.longitude),
          // Use default marker icon
          onTap: () {
            setState(() {
              _selectedSupplier = supplier;
            });
          },
        ),
      );
    }

    // Add user location marker
    if (_locationIcon != null) {
      markers.add(
        Marker(
          markerId: MarkerId("user_location"),
          position: _initialPosition,
          icon: _locationIcon!,
          anchor: Offset(0.5, 0.5),
        ),
      );
    }

    return markers;
  }

  void _onMapTapped(LatLng position) {
    // Dismiss the popup when the map is tapped
    setState(() {
      _selectedSupplier = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          // Google Map Widget
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: 12),
            onMapCreated: (controller) {
              _mapController = controller;
              _mapController.setMapStyle(_mapStyle);
              _getUserLocation();
            },
            onTap: _onMapTapped,
            myLocationEnabled: false,
            myLocationButtonEnabled: true,
            markers: _createMarkers(),
          ),
          // Supplier Popup
          if (_selectedSupplier != null)
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: SupplierPopup(supplier: _selectedSupplier!),
            ),
        ],
      );
    });
  }
}
