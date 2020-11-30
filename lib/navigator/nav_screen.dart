import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/screens/explore/explore_screen.dart';
import 'package:travel/screens/home/home_screen.dart';


class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentTab = 0;

  static List<Widget> _widgetOptions = <Widget>[
  HomeScreen(),
  ExploreScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(child: _widgetOptions.elementAt(_currentTab),)
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value; 
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.compass,
              size: 25.0,
            ),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
