import 'package:compassionapp/features/locations/location_data.dart';
import 'package:compassionapp/services/visisbility_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late maps.GoogleMapController _mapController;
  Position? _currentPosition;
  String _selectedLocation = 'Ikke valgt';
  final Set<maps.Marker> _markers = {};


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
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  _currentPosition = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  ));

  if (!mounted) return;

  setState(() {
    _markers.add(
      maps.Marker(
        markerId: maps.MarkerId('currentLocation'),
        position: maps.LatLng(
            _currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: maps.InfoWindow(title: 'Din placering'),
      ),
    );
  });
}


  void _addMarker(maps.LatLng position, String title, String url) {
    final markerId = maps.MarkerId(title);
    setState(() {
      _markers.add(
        maps.Marker(
          markerId: markerId,
          position: position,
          infoWindow: maps.InfoWindow(
            title: title,
            snippet: "Klik for mere information",
            onTap: () {
              _showInfoDialog(title, url);
            },
          ),
        ),
      );
      _selectedLocation = title;
      _mapController.animateCamera(
        maps.CameraUpdate.newLatLngZoom(position, 14.4746),
      );
    });

    // Show the InfoWindow after the marker is added
    Future.delayed(const Duration(milliseconds: 300), () {
      _mapController.showMarkerInfoWindow(markerId);
    });
  }

  void _showInfoDialog(String title, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Information omkring stedet og hvad de tilbyder, tryk på linket for at se mere',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text('Åben Link'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Luk'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapHeight = screenHeight * 0.6;

    return Scaffold(
      body: Consumer<VisibilityManager>(
        builder: (context, visibilityManager, child) {
          return Column(
            children: [
              SizedBox(
                height: mapHeight,
                child: maps.GoogleMap(
                  initialCameraPosition: maps.CameraPosition(
                    target: maps.LatLng(55.3680, 10.4289),
                    zoom: 14.4746,
                  ),
                  markers: _markers,
                  onMapCreated: (maps.GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Valgt placering: $_selectedLocation',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _buildLocationButtons(visibilityManager),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStyledButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 9.0),
        textStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> _buildLocationButtons(VisibilityManager visibilityManager) {
    return locations.map((location) {
      final name = location.name;
      if (visibilityManager.locationVisibility[name] ?? true) {
        return _buildStyledButton(
          onPressed: () => _addMarker(
            location.latLng,
            name,
            location.url,
          ),
          text: name,
        );
      }
      return Container();
    }).toList();
  }
}