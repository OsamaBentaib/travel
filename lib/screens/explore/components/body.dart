import 'package:flutter/material.dart';
import 'package:travel/screens/explore/components/lists_data.dart';
import 'package:travel/utils/Providers/database.dart';



class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final dbHelper = DatabaseHelper.instance;
  String dstcity = "";
  int dstid ;
  initPrefs() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      dstcity = row['city'];
      dstid = row['_id'];
    });
    setState(() {});
  }
  void initState() {
    super.initState();

    initPrefs();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Container(
             child: UrbanPlacesList(),
           ),
           Container(
             child: MountainousPlacesList(),
           ),
           Container(),
           Container(),
           Container(),
         ],
       ),
    );
  }
}














