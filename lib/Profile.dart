import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Widget profile(context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.6, 0.9],
                    colors: [Colors.white, Color(0xffFED8B1)])),*/
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            profile(context),
          ],
        ),
      ),
    );
  }
}
