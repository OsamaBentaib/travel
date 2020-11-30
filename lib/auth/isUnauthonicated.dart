
import 'package:flutter/material.dart';
import 'package:travel/screens/landing.dart';
import 'package:travel/utils/Providers/database.dart';
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