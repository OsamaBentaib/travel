
import 'package:flutter/material.dart';
import 'package:travel/screens/explore/components/body.dart';



class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}





