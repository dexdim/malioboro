import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Widget text(context, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          child: Text(
            ':  ',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget profile(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Text(
                'Edit profile',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          text(context, 'Full Name', 'Alexander Adimas'),
          text(context, 'Email', 'alexanderadimas@gmail.com'),
          text(context, 'Mobile Number', '0888060605032'),
          text(context, 'Address', 'Perumahan Pondok Intan Permai 3'),
          text(context, 'Birthdate', '11 July 1992'),
          text(context, 'Gender', 'Male'),
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
                  'assets/profile.jpg',
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
                top: MediaQuery.of(context).size.height / 6,
              ),
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
                elevation: 3,
                child: Image.asset('assets/icon/profpic.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
