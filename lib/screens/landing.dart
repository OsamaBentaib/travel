import 'package:travel/Animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import "package:travel/constants.dart";
import 'package:travel/main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel/utils/Providers/database.dart';
import 'package:travel/utils/Providers/db_providers.dart';

Future<DestinationCTIT> fetchDestinationCTIT() async {
  final response =
      await http.get('https://api-server-travel.herokuapp.com/api/cities/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DestinationCTIT.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DestinationCTIT');
  }
}

class DestinationCTIT {
  final int id;
  final String title;
  final String city;
  final String image;
  final String description;
  final String founded;
  final String population;
  final int unite;
  final int country;
  
  DestinationCTIT({this.id, this.title, this.city, this.image, this.description, this.founded, this.population, this.unite, this.country});

  factory DestinationCTIT.fromJson(Map<String, dynamic> json) {
    return DestinationCTIT(
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



class Cities {
  const Cities(this.id,this.city);

  final String city;
  final int id;
}
class Landing extends StatefulWidget {
  
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final dbHelper = DatabaseHelper.instance;
  Cities selectedCity;
  List<Cities> cities = <Cities>[const Cities(1,'Chefchaouen'), const Cities(2,'Tetouan'), const Cities(3,'Tanger'), const Cities(4,'Fes')];
  Future<DestinationCTIT> futureDSTCTIT;
  int idcity;
  String title;
  String city;
  String image;
  String description;
  String founded;
  String population;
  int unite;
  int country;
      
  @override
  void initState() {
    selectedCity=cities[0];
  }
  _loaddata() async {
    futureDSTCTIT = fetchDestinationCTIT();
    futureDSTCTIT.then((value) {
      idcity = value.id;
      title= value.title;
      city= value.city;
      description = value.description ;
      image= value.image;
      founded= value.founded;
      population= value.population;
      unite= value.unite;
      country= value.country;
      _loadFromApi();
    });
  }
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD8ECF1),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor: Color(0xFFD8ECF1),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/santorini.jpg'),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD8ECF1),
                            Color(0xFFD8ECF1).withOpacity(.3)
                          ]
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(1, Text("Select Destination ", style: 
                              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)
                            ,)),
                            FadeAnimation(1, Text("حدد وجهتك", style: 
                              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)
                            ,)),
                            SizedBox(height: 20,),
                            DropdownButton<Cities>(
      value: selectedCity,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: primaryColor, fontSize: 17,),
      underline: Container(
        height: 2,
        color: primaryColor,
      ),
      onChanged: (Cities newValue) {
        setState(() {
          selectedCity = newValue;
          int idkey = selectedCity.id;
    print(selectedCity.city +" "+ "$idkey");
        });
      },
      items: cities.map((Cities user) {
                  return DropdownMenuItem<Cities>(
                    
                    value: user,
                    child: new Text(
                      user.city,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
    )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1.6, Text("Emma Charlotte Duerre Watson was born in Paris, France, to English parents, Jacqueline Luesby and Chris Watson, both lawyers. She moved to Oxfordshire when she was five, where she attended the Dragon School.", 
                        style: TextStyle(color: Colors.black, height: 1.4),)),
                        SizedBox(height: 40,),
          SizedBox(height: 120,),
                        
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          Positioned.fill(
            bottom: 50,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: ()  {  
                    _insert();
                    _query();
                    _loaddata();
                    },
                  child: FadeAnimation(2,
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: primaryColor,
                        ),
                        child:Align(
                          child: Row(children: <Widget>[
                            SizedBox(width: 55),
                            isLoading
          ? SizedBox(width: 20,height: 20,child: CircularProgressIndicator(strokeWidth: 2,))
          : SizedBox(width: 20,height: 20,),
                            
                          SizedBox(width: 15),
                          Text("Continue - متابعة", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,fontSize: 16),),
                          
                        ],) ), 
                      ),
                    ),
                  )
              
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5/ 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.3)
              ]
            )
          ),
          child: Align(
            child: Icon(Icons.play_arrow, color: Colors.black, size: 70,),
          ),
        ),
      ),
    );
  }
  void _insert() async{
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : selectedCity.city,
      DatabaseHelper.columnId: selectedCity.id,
    };
    final id = await dbHelper.insert(row);
    print('inserted id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
  
  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }


  // import REST API and Add to db

  _loadFromApi() async {
    setState(() {
      isLoading = true;
      
    });
    print("Loading............");
    Map<String, dynamic> row = {
      
      DBProvider.columnid: idcity,
      DBProvider.columntitle : title,
      DBProvider.columncountry : country,
      DBProvider.columnimage : image,
      DBProvider.columncity : city,
      DBProvider.columnfounded : founded,
      DBProvider.columnunite : unite,
      DBProvider.columndescription : description,
      DBProvider.columnpopulation: population,
    };
    final id = await DBProvider.db.insertDestinationIt(row);
    print('inserted id: $id');
    print("screen finished !!!");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
       builder: (BuildContext context) => IsAuthentecated()));
    setState(() {
      isLoading = false;
    });
    
  }
  void _queryDestinationit() async {
    final allRows = await DBProvider.db.queryAllRowsDestinationIt();
    print('query all Desination');
    allRows.forEach((row) => print(row));
  }
  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllDestinationIts();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('Destination deleted');
  }
  
}
