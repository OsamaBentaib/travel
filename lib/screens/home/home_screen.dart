import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/screens/home/components/body.dart';
import 'package:travel/utils/Providers/database.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
     void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
    void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

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
    return Scaffold(
      body: Body(dstcity: dstcity, dstid: dstid),
    );
  }
}