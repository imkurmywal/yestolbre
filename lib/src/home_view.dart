import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yestolbre/src/map_view.dart';
import 'package:yestolbre/src/models/category.dart';
import 'package:yestolbre/src/models/merchnat.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ref = FirebaseDatabase.instance.reference();
  List<Merchant> allMerchants = new List<Merchant>();
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
  void _itemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getList() async {
    ref.child("merchants").onValue.listen((Event event) {
      allMerchants.clear();
      if (event.snapshot.value == null) {
        // _end_loading();
        return;
      }

      for (Map<dynamic, dynamic> value in event.snapshot.value.values) {
        print(value);
        if (mounted) {
          setState(() {
            allMerchants.add(new Merchant.fromJson(value));
          });
          // _end_loading();
        }
      }
      print(allMerchants[0].offers[0]);
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
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
                child: MapView(
                  merchants: allMerchants,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 73,
                  color: Colors.blue[500],
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
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
        )
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Theme.of(context).primaryColor,
        //   onTap: _itemTapped,
        //   currentIndex: _selectedIndex,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.fastfood),
        //       title: Text('Food'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.hotel),
        //       title: Text('Hotels'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.event),
        //       title: Text("Events"),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.help_outline),
        //       title: Text("Services"),
        //     ),
        //   ],
        // ),
        );
  }
}
