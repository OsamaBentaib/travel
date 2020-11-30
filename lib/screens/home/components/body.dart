import 'package:flutter/material.dart';
import 'package:travel/screens/details.dart';
import 'package:travel/screens/home/components/places.dart';
import 'package:travel/main.dart';
import 'package:travel/Animations/FadeAnimation.dart';
import 'package:travel/constants.dart';
import 'package:travel/utils/Providers/database.dart';
import 'package:travel/utils/Providers/db_providers.dart';
class Body extends StatefulWidget {
  final int dstid;
  final String dstcity;
  Body({Key key, this.dstcity, this.dstid}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
    final dbHelper = DatabaseHelper.instance;
    int imageStatue =0;
  int idcity;
  String title;
  String city;
  String image;
  String description;
  String founded;
  String population;
  int unite;
  int country;
  
  initPrefs() async {
    final allRows = await DBProvider.db.queryAllRowsDestinationIt();
    allRows.forEach((row) {
      idcity = row['id'];
      title= row['title'];
      city= row['city'];
      description = row['description'] ;
      image= row['image'];
      founded= row['founded'];
      population= row['population'];
      unite= row['unite'];
      country= row['country'];
    });
    
    setState(() {});
  }
  
  void initState() {
    super.initState();
    initPrefs();
    
  }
  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        image: NetworkImage("${base_URL+image}"),
                        fit: BoxFit.cover
                      ),
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
                            FadeAnimation(1, Text(city == null? '' : city, style: 
                              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)
                            ,)),
                            FadeAnimation(1, Text(title == null? '' : title, style: 
                              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                            ,)),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsScreen(
                                    city: city,
                                    title: title,
                                    description: description,
                                    image: image,
                                    population: population,
                                    founded: founded,
                                    location: "North Morocco"
                                  ),
                                ),
                              ),
                              child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white
                                  ),
                        child: Center(child: Text("Read More", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        SizedBox(height: 10,),
                        Places(),
          SizedBox(height:20,),
                        
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top:30),
            child: GestureDetector(
      onTap: () {
            _delete();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                        builder: (BuildContext context) => IsUnAuthentecated()
                        )
                        );
              } ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(
              "Change Destination",
              style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                  
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 70,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
          ],
        ),
      ),
    ),
          ),
          
        ],
      );

    
  }
  
           
  
}




