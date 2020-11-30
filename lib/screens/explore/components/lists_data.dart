import 'package:flutter/material.dart';
import 'package:travel/screens/explore/components/Lists/lists.dart';
import 'package:http/http.dart' as http;
import 'package:travel/utils/models/models.dart';
import '../../../load.dart';


class UrbanPlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlacesAPI>>(
        future: fetchPlacesAPIs(http.Client(), 1),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
            ? 
            Container(
              height: 300,
              child: PlacesList(place: snapshot.data),
            )
            : Load();
        },
      );
  }
}

class MountainousPlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlacesAPI>>(
        future: fetchPlacesAPIs(http.Client(), 2),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
            ? 
            Container(
              height: 300,
              child: PlacesList(place: snapshot.data),
            )
            : Load();
        },
      );
  }
}