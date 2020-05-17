import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yestolbre/src/merchnat_view.dart';

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
  BitmapDescriptor pin;

  LatLng myLocation;

  @override
  void initState() {
    super.initState();
    setPin();
    _locationServices();
  }

  void _setMarker() {
    final marker = Marker(
        markerId: MarkerId("id"),
        position: LatLng(myLocation.latitude, myLocation.longitude),
        icon: pin,
        // infoWindow: InfoWindow(title: "Its me"),
        onTap: () {
          print("its clicked.");
          showBottomSheet();
        });
    _markers["id"] = marker;
  }

  void setPin() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(50, 56)), 'assets/pin.png')
        .then((onValue) {
      pin = onValue;
    });
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
        _setMarker();
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

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            child: SafeArea(
              child: Wrap(
                // alignment: WrapAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.asset(
                                'assets/offer.jpeg',
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Merchant Name",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Merchant Address",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MerchantView()));
                            },
                            child: Container(
                              width: 160,
                              height: 30,
                              child: Center(
                                child: Text(
                                  "View Offers",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              // padding: EdgeInsets.all(2),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
