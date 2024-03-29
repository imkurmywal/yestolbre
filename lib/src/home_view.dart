import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:yestolbre/src/Firebase/merchant_firebase.dart';
import 'package:yestolbre/src/all_partners_view.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/src/models/category.dart';
import 'package:yestolbre/src/models/merchnat.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show TargetPlatform;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ref = FirebaseDatabase.instance.reference();
  List<Merchant> allMerchants = new List<Merchant>();
  List<Merchant> filteredMerchants = new List<Merchant>();
  var _location = new Location();
  final Map<String, Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pin;

  LatLng myLocation;
  String _mapStyle;
  int _selectedIndex = 0;
  List<Category> categories = [
    Category(
      title: "Eat",
      index: 0,
    ),
    Category(
      title: "Travel",
      index: 1,
    ),
    Category(
      title: "Events",
      index: 2,
    ),
    Category(
      title: "Health",
      index: 3,
    ),
    Category(
      title: "Services",
      index: 4,
    ),
    Category(
      title: "Trends",
      index: 5,
    ),
  ];

  void _setMarker() {
    var platform = Theme.of(context).platform;

    _markers.clear();
    for (Merchant merchant in filteredMerchants) {
      final marker = Marker(
          markerId: MarkerId(merchant.merchantId),
          position: LatLng(merchant.latitude, merchant.longitude),
          icon: BitmapDescriptor.fromAsset(
              'assets/pin${platform == TargetPlatform.iOS ? "_ios" : ""}.png'),
          onTap: () {
            showBottomSheet(merchant);
          });
      _markers[merchant.merchantId] = marker;
    }
  }

  void _locationServices() {
    _location.requestPermission();
    _location.changeSettings(
        accuracy: LocationAccuracy.HIGH, distanceFilter: 150);

    _location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        myLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        _setMarker();
      });
    });
  }

  void getList() async {
    MerchantDB.shared.getMerchants(fetched: (List<Merchant> merchants) {
      allMerchants = merchants;
      filterCategory(category: categories[_selectedIndex].title);
      if(this.mounted) {
        setState(() {
          _setMarker();
        });
      }
    });
  }

  filterCategory({String category}) {
    filteredMerchants = allMerchants
        .where((merchant) => merchant.category
            .toLowerCase()
            .split(",")
            .contains(category.toLowerCase()))
        .toList();
  }

  filterByKeyword({String keyword}) {
    String keywd = keyword.toLowerCase();
    filteredMerchants.clear();
    print("working");
    print(allMerchants.length);
    allMerchants.forEach((merchant) async {
      if (merchant.name.toLowerCase().contains(keywd) ||
          merchant.address.toLowerCase().contains(keywd)) {
        filteredMerchants.add(merchant);
        return;
      }
      if (merchant.offers == null) {
        return;
      }
      merchant.offers.forEach((offer) {
        if (offer.title.toLowerCase().contains(keywd)) {
          filteredMerchants.add(merchant);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _locationServices();
    getList();
//    rootBundle.loadString('assets/style.txt').then((string) {
//      _mapStyle = string;
//    });
  }

  initPlatformState() async {
    OneSignal.shared.init("3f350164-e29d-4e1d-81ac-5862587446f5", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.fromLTRB(14, 10, 14, 10),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        hintText: "Search keyword", border: InputBorder.none),
                    onSubmitted: (keyword) {
                      setState(() {
                        filterByKeyword(keyword: keyword);
                        print("fliter done.");
                        _setMarker();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 73,
                child: Container(
                    child: myLocation == null
                        ? Center(
                            child: Text("Map is loading"),
                          )
                        : Stack(
                            children: <Widget>[
                              GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: myLocation,
                                  zoom: 10,
                                ),
                                markers: _markers.values.toSet(),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  controller.setMapStyle(_mapStyle);
                                },
                                myLocationEnabled: true,
                              ),
                              Positioned(
                                top: 12,
                                right: platform == TargetPlatform.iOS ? 10 : 60,
                                child: InkWell(
                                  child: Image.asset(
                                    "assets/all_partners.png",
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllPartnersView()));
                                  },
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: -10,
                                child: Image.asset(
                                  "assets/logo.png",
                                  height: 40,
                                ),
                              ),
                            ],
                          )),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 74,
                  color: Color(0xff5ed4f0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if(this.mounted) {
                              setState(() {
                                _selectedIndex = index;
                                filterCategory(
                                    category: categories[_selectedIndex].title);
                                _setMarker();
                              });
                            }
                          },
                          child: Container(
                            child: Container(
                              width:
                                  (MediaQuery.of(context).size.width - 20) / 4,
                              // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      "assets/tab_icons/${categories[index].title.toLowerCase()}${_selectedIndex == categories[index].index ? "_white" : ""}.png",
                                      height: 30,
                                      width: 35),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categories[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: _selectedIndex ==
                                                categories[index].index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
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
