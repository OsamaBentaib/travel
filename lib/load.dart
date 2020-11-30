import 'package:flutter/material.dart';

class Load extends StatelessWidget {
  const Load({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}