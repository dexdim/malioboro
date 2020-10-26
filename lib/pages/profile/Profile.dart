import 'package:flutter/material.dart';
import 'package:malioboromall/pages/profile/EditProfile.dart';
import 'package:malioboromall/pages/user/Change.dart';
import 'package:malioboromall/pages/user/Login.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                    child: EditProfile(),
                    type: PageTransitionType.fade,
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
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
          text(context, 'Full Name', 'Joko Widodo'),
          text(context, 'Address', 'Istana Negara Bogor'),
          text(context, 'Birthdate', '21 June 1961'),
          text(context, 'Gender', 'Male'),
          text(context, 'Mobile Number', '08123456789'),
          text(context, 'Email', 'jokowi@gmail.com'),
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                    child: Change(),
                    type: PageTransitionType.fade,
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
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
          PageTransition(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            child: Login(),
            type: PageTransitionType.fade,
            inheritTheme: true,
            ctx: context,
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
                    'assets/profile.png',
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
