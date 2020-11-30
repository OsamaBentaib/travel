import 'package:flutter/material.dart';



class MorePictures extends StatelessWidget {
  final city ;
  MorePictures({this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
  
  scrollDirection: Axis.horizontal,
  children: <Widget>[
    Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 160.0,
      color: Colors.red,
      
    ),
    Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 160.0,
      color: Colors.blue,
    ),
    Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 160.0,
      color: Colors.green,
    ),
    Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 160.0,
      color: Colors.yellow,
    ),
    Container(
      margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: 160.0,
      color: Colors.orange,
    ),
  ],
),
    );
  }
}