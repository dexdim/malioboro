import 'package:flutter/material.dart';
import 'package:malioboromall/pages/Menu.dart';
import 'package:page_transition/page_transition.dart';

class Change extends StatefulWidget {
  Change({Key key}) : super(key: key);
  static final String route = 'Change-route';

  @override
  ChangeState createState() => ChangeState();
}

class ChangeState extends State<Change> {
  Widget title() {
    return Text(
      'Change Password',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: Colors.black,
        shadows: [
          Shadow(
            offset: Offset(0.00, 2.00),
            color: Colors.brown.withOpacity(0.50),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }

  Widget backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget form(String title, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: TextFormField(
              onSaved: (value) => title = value,
              style: TextStyle(
                fontSize: 18,
              ),
              obscureText: isPassword,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: title,
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.brown,
                    ),
                  ),
                  filled: true),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget submitButton(String title) {
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
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            child: Menu(),
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

  Widget changeForm() {
    return Column(
      children: [
        form('Old Password', isPassword: true),
        form('New Password', isPassword: true),
        form('Confirm New Password', isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.8],
                colors: [
                  Colors.white,
                  Color(0xfffee18e),
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                title(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                changeForm(),
                SizedBox(
                  height: 30,
                ),
                submitButton('SUBMIT'),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: backButton(),
          ),
        ],
      ),
    );
  }
}
