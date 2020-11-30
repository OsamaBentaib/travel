
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';

import 'package:travel/utils/Providers/database.dart';
import 'package:travel/utils/models/destination_model.dart';
import 'package:travel/utils/providers/db_provider.dart';

class DestinationItApiProvider {
  getAllDestinationIts() async {
    final dbHelper = DatabaseHelper.instance;
  int id;
  final allRows = await dbHelper.queryAllRows();
  print("Is called api" );
    allRows.forEach((row) {print(row);id = row['_id'];});
  final url= "https://api-server-travel.herokuapp.com/api/cities/" + "$id";
  print(url);
  Response response = await Dio().get(url);
  print(response.data);
  return DBProvider.db.createDestinationIt(DestinationIt.fromJson(json.decode(response.data)));
  }
}