import 'package:flutter/material.dart';
import 'package:yestolbre/src/map_view.dart';
import 'package:yestolbre/src/models/category.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  List<Category> categories = [
    Category(
      title: "Food",
      icon: Icon(Icons.fastfood),
      index: 0,
    ),
    Category(
      title: "Hotels & Travel",
      icon: Icon(Icons.hotel),
      index: 1,
    ),
    Category(
      title: "Events",
      icon: Icon(Icons.event),
      index: 2,
    ),
    Category(
      title: "Services",
      icon: Icon(Icons.help_outline),
      index: 3,
    ),
    Category(
      title: "Fasion",
      icon: Icon(Icons.fastfood),
      index: 4,
    ),
    Category(
      title: "Health & Beauty",
      icon: Icon(Icons.beach_access),
      index: 5,
    ),
  ];
  void _itemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
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
                bottom: 100,
                child: MapView(
                  index: _selectedIndex,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 70,
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
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  categories[index].icon,
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categories[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: _selectedIndex ==
                                                categories[index].index
                                            ? Colors.grey[300]
                                            : Colors.white),
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
