import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/utils/models/models.dart';
import 'package:travel/widgets/home_list.dart';
import 'package:http/http.dart' as http;

class Places extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Container(height: 300,child: PhotosList(photos: snapshot.data),)
              : Center(child: CircularProgressIndicator());
        },
      );
  }
}


