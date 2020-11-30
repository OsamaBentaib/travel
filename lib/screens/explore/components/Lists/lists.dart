import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/constants.dart';
import 'package:travel/screens/destination_screen.dart';
import 'package:travel/utils/models/models.dart';


class PlacesList extends StatelessWidget {
  final List<PlacesAPI> place;

  PlacesList({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: place.length,
      itemBuilder: (context, index) {
      return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DestinationScreen(
                image: place[index].image,
                description: place[index].description,
                title: place[index].title,
                city: place[index].city.city,
                founded: place[index].founded,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 310.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0),
                        blurRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: "$base_URL"+"${place[index].image}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            height: 300,
                            width: 300.0,
                            image: NetworkImage("${base_URL+place[index].image}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              place[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.locationArrow,
                                  size: 10.0,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  place[index].city.city,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}