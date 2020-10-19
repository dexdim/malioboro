import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Widget profile(context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.20,
      ),
      child: Image.network(
          'http://www.pngall.com/wp-content/uploads/2018/04/Under-Construction-PNG-Picture.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'SORRY!',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          profile(context),
        ],
      ),
    );
  }
}
