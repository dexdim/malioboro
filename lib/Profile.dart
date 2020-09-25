import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _title() {
    return Text(
      'PROFILE',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Color(0xff333333),
        shadows: [
          Shadow(
            offset: Offset(0.00, 2.00),
            color: Color(0xffd97c29).withOpacity(0.50),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }

  Widget _profile() {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
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
              _profile(),
            ]))));
  }
}
