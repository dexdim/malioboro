import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Widget text(context, String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22),
    );
  }

  Widget profile(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(context, 'Full Name :'),
          text(context, 'Email :'),
          text(context, 'Phone Number :'),
          text(context, 'Address :'),
          text(context, 'Birthdate :'),
          text(context, 'Gender :'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/profile.png',
                ),
              ),
              Expanded(
                child: profile(context),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5,
              ),
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
