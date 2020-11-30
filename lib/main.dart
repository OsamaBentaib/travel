import 'package:flutter/material.dart';
import 'package:travel/navigator/nav_screen.dart';
import 'package:travel/screens/landing.dart';
import 'package:travel/utils/Providers/database.dart';

void main() => runApp(MaterialApp(home: SplashScreen(),debugShowCheckedModeBanner: false,));


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final dbHelper = DatabaseHelper.instance;
  @override
  String initScreen = "";
  initPrefs() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => print(""));
    if (allRows.length > 0){
       initScreen = "authenecated";
    }else{
       initScreen = "Landing";
    }
    setState(() {});
  }
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (initScreen =="authenecated")
    {
       return IsAuthentecated();
    }
    else
    { 
      return IsUnAuthentecated();
    }
  }
}

class IsAuthentecated extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override

  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: NavigationScreen(),
      
    );
  }
}
class IsUnAuthentecated extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override

  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Travel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home: Landing(),
      
    );
  }
}

