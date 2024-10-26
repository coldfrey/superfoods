import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(0, 0);
  BitmapDescriptor? _locationIcon;

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
    _createLocationIcon(); // Create the custom location icon
    _getUserLocation();
  }

  Future<void> _createLocationIcon() async {
    _locationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(25, 25)), // Specify the size of the icon
      'assets/blue_circle_icon.png', // A blue circular image stored in your assets folder
    );
  }

  Future<void> _getUserLocation() async {
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

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController.setMapStyle(_mapStyle);
        _getUserLocation();
      },
      myLocationEnabled: false, // Turn off default location indicator
      myLocationButtonEnabled: true,
      markers: _locationIcon == null
          ? {}
          : {
              Marker(
                markerId: MarkerId("user_location"),
                position: _initialPosition,
                icon: _locationIcon!,
                anchor: Offset(0.5, 0.5), // Center the icon
              ),
            },
    );
  }
}
