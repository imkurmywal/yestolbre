import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  final index;
  MapView({@required this.index});
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  var _location = new Location();
  final Map<String, Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  LatLng myLocation;

  @override
  void initState() {
    super.initState();
    _locationServices();
  }

  void _locationServices() {
    _location.requestPermission();
    _location.changeSettings(
        accuracy: LocationAccuracy.HIGH, distanceFilter: 150);

    _location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        print(currentLocation);
        myLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        // getData(myLocation);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: myLocation == null
          ? Center(
              child: Text("Map is loading"),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: myLocation,
                zoom: 10,
              ),
              markers: _markers.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
    );
  }
}
