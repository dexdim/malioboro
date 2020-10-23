import 'package:flutter/material.dart';
import 'package:malioboromall/pages/user/Login.dart';

class Profile extends StatelessWidget {
  Widget text(context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            child: Text(
              ':  ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
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
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          text(context, 'Full Name', 'Alexander Adimas'),
          text(context, 'Address', 'Perumahan Pondok Intan Permai 3'),
          text(context, 'Birthdate', '11 July 1992'),
          text(context, 'Gender', 'Male'),
          text(context, 'Mobile Number', '0888060605032'),
          text(context, 'Email', 'alexanderadimas@gmail.com'),
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Text(
                'Change password',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: logoutButton(context),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget logoutButton(context) {
    return RaisedButton(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.brown,
          width: 1,
        ),
      ),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 50,
      ),
      child: Text(
        'LOGOUT',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      //onPressed: validateAndSubmit,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Color(0xfffee18e),
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
                child: Material(
                  elevation: 5,
                  child: Image.asset(
                    'assets/profile.jpg',
                  ),
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
                top: MediaQuery.of(context).size.height / 8,
              ),
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 10,
                ),
                shape: BoxShape.circle,
              ),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
                child: Image.asset('assets/icon/profpic.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
