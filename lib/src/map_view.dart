import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/src/models/merchnat.dart';

class MapView extends StatefulWidget {
  List<Merchant> merchants = new List<Merchant>();
  MapView({@required this.merchants});
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
    for (Merchant merchant in widget.merchants) {
      final marker = Marker(
          markerId: MarkerId(merchant.merchantId),
          position: LatLng(merchant.latitude, merchant.longitude),
          icon: pin,
          // infoWindow: InfoWindow(title: "Its me"),
          onTap: () {
            print("its clicked.");
            showBottomSheet(merchant);
          });
      _markers[merchant.merchantId] = marker;
    }
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
                zoom: 12,
              ),
              markers: _markers.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
    );
  }

  void showBottomSheet(Merchant merchant) {
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
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  merchant.logoUrl,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    merchant.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    merchant.address,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        merchant.category,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                                      builder: (context) => MerchantView(
                                            merchant: merchant,
                                          )));
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
