import 'package:flutter/material.dart';
import 'package:travel/screens/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/constants.dart';
import 'package:travel/Animations/FadeAnimation.dart';
import 'package:travel/utils/models/models.dart';


class DestinationItem extends StatefulWidget {
  DestinationItem({Key key}) : super(key: key);

  @override
  _DestinationItemState createState() => _DestinationItemState();
}

class _DestinationItemState extends State<DestinationItem> {
  Future<Destination> futureDestination;
  @override
  void initState() {
    super.initState();
    futureDestination = fetchDestination();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Destination>(
            future: futureDestination,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          );
  }
}
              


