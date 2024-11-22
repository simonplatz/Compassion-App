import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/directions.dart' as webservice;

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late maps.GoogleMapController _mapController;
  Position? _currentPosition;
  String _selectedLocation = 'Not selected';
  final maps.LatLng _southernUniversityDenmark = maps.LatLng(55.3680, 10.4289);
  final Set<maps.Marker> _markers = {};
  final List<maps.LatLng> _polylineCoordinates = [];
  final webservice.GoogleMapsDirections _directionsService = webservice.GoogleMapsDirections(apiKey: 'YOUR_API_KEY');

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _markers.add(
        maps.Marker(
          markerId: maps.MarkerId('currentLocation'),
          position: maps.LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: maps.InfoWindow(title: 'Your Location'),
        ),
      );
    });
  }

  Future<void> _getDirections() async {
    if (_currentPosition == null) return;

    final directions = await _directionsService.directionsWithLocation(
      webservice.Location(lat: _currentPosition!.latitude, lng: _currentPosition!.longitude),
      webservice.Location(lat: _southernUniversityDenmark.latitude, lng: _southernUniversityDenmark.longitude),
    );

    if (directions.isOkay) {
      setState(() {
        _polylineCoordinates.clear();
        directions.routes.first.legs.first.steps.forEach((step) {
          _polylineCoordinates.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
          _polylineCoordinates.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Stack(
        children: [
          maps.GoogleMap(
            initialCameraPosition: maps.CameraPosition(
              target: maps.LatLng(55.3680, 10.4289),
              zoom: 14.4746,
            ),
            markers: _markers,
            polylines: {
              maps.Polyline(
                polylineId: maps.PolylineId('route'),
                points: _polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            },
            onMapCreated: (maps.GoogleMapController controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              children: [
                Text(
                  'Your Location: $_selectedLocation',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedLocation = 'Southern University Denmark';
                      _markers.add(
                        maps.Marker(
                          markerId: maps.MarkerId('southernUniversityDenmark'),
                          position: _southernUniversityDenmark,
                          infoWindow: maps.InfoWindow(title: 'Southern University Denmark'),
                        ),
                      );
                      _getDirections();
                    });
                  },
                  child: const Text('Select Location'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}