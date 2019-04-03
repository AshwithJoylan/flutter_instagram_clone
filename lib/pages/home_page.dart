import 'package:fire/tabs/home-tab.dart';
import 'package:flutter/material.dart';
import 'package:fire/insta_icons_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var activeTabIndex = 0;

  @override
    void initState() {
      super.initState();
    }

  final _tabs = [
    HomeTab(),
    Text('Search'),
    Text('Add Media'),
    Text('Likes'),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),title: Container(height: 0.0)),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Container(height: 0.0)),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), title: Container(height: 0.0)),
          BottomNavigationBarItem(activeIcon: Icon(Icons.favorite), icon: Icon(Icons.favorite_border), title: Container(height: 0.0)),
          BottomNavigationBarItem(activeIcon: Icon(Icons.person), icon: Icon(Icons.person_outline), title: Container(height: 0.0)),
        ],
        currentIndex: activeTabIndex,
        onTap: _setActiveIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        iconSize: 30.0,
      ),
      body: Center(
        child: _tabs.elementAt(activeTabIndex),
      ),
    );
  }

  void _setActiveIndex(index) {
    setState(() {
          activeTabIndex = index;
        });
  }
}