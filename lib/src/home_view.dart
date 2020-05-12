import 'package:flutter/material.dart';
import 'package:yestolbre/src/map_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

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
      body: MapView(
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _itemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Food'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            title: Text('Hotels'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text("Events"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            title: Text("Services"),
          ),
        ],
      ),
    );
  }
}
