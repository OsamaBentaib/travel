import 'dart:convert';

List<DestinationIt> DestinationItFromJson(String str) =>
    List<DestinationIt>.from(json.decode(str).map((x) => DestinationIt.fromJson(x)));

String DestinationItToJson(List<DestinationIt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationIt {
  final int id;
  final String title;
  final String city;
  final String image;
  final String description;
  final String founded;
  final String population;
  final int unite;
  final int country;

  DestinationIt({
    this.id,
    this.title,
    this.city,
    this.image,
    this.description,
    this.founded,
    this.population,
    this.unite,
    this.country,
  });

  factory DestinationIt.fromJson(Map<String, dynamic> json) => DestinationIt(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "city": city,
        "image": image,
        "description": description,
        "founded": founded,
        "population": population,
        "unite": unite,
        "country": country,
      };
}