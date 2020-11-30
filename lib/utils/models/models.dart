import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:travel/utils/Providers/database.dart';


class City{
  int id;
  String city;

  City({
    this.id,
    this.city
});
factory City.fromJson(Map<String, dynamic> json){
  return City(
    id: json['id'],
    city: json['city']
  );
}
}
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://api-server-travel.herokuapp.com/api/destinations/city/1');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int id;
  final String title;
  City city;
  final String image;
  final String description;
  final String founded;

  Photo({this.id, this.title, this.city, this.image, this.description, this.founded});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      city: City.fromJson(json['city']),
      image: json['image'] as String,
      description: json['description'] as String,
      founded: json['founded'] as String,
    );
  }
}
/*   Descover Top Places Near City */

Future<List<PlacesAPI>> fetchPlacesAPIs(http.Client client, int content) async {
  final response =
      await client.get('https://api-server-travel.herokuapp.com/api/destinations/city/1');

  // Use the compute function to run parsePlacesAPIs in a separate isolate.
  return compute(parsePlacesAPIs, response.body);
}

// A function that converts a response body into a List<PlacesAPI>.
List<PlacesAPI> parsePlacesAPIs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<PlacesAPI>((json) => PlacesAPI.fromJson(json)).toList();
}

class PlacesAPI {
  final int id;
  final String title;
  City city;
  final String image;
  final String description;
  final String founded;

  PlacesAPI({this.id, this.title, this.city, this.image, this.description, this.founded});

  factory PlacesAPI.fromJson(Map<String, dynamic> json) {
    return PlacesAPI(
      id: json['id'] as int,
      title: json['title'] as String,
      city: City.fromJson(json['city']),
      image: json['image'] as String,
      description: json['description'] as String,
      founded: json['founded'] as String,
    );
  }
}


Future<Destination> fetchDestination() async {
  final dbHelper = DatabaseHelper.instance;
  int id;
  final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {id = row['_id'];});
  final url= "https://api-server-travel.herokuapp.com/api/cities/" + "$id";
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Destination.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load $url');
  }
}

class Destination {
  final int id;
  final String title;
  final String city;
  final String image;
  final String description;
  final String founded;
  final String population;
  final int unite;
  final int country;
  
  Destination({this.id, this.title, this.city, this.image, this.description, this.founded, this.population, this.unite, this.country});


  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as int,
      title: json['title'] as String,
      city: json['city'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      founded: json['founded'] as String,
      population: json['population'] as String,
      unite: json['unite'] as int,
      country: json['country'] as int,
    );
  }
}
