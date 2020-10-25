import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);
  static final String route = 'SignUp-route';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool accept = false;

  Widget title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "SIGN UP",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: Colors.black,
          shadows: [
            Shadow(
              offset: Offset(0.00, 2.00),
              color: Color(0xffd97c29).withOpacity(0.50),
              blurRadius: 5,
            ),
          ],
        ),
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
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Color(0xfffee18e),
    );
  }

  Widget loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account? ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: Login(),
                  type: PageTransitionType.fade,
                  inheritTheme: true,
                  ctx: context,
                ),
              );
            },
            child: Text(
              'Login here!',
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget signupform() {
    return Column(
      children: <Widget>[
        form('Full Name'),
        form('Email'),
        form('Password', isPassword: true),
        form('Confirm Password', isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String tnc =
        "By clicking 'SUBMIT' you're agree to our Privacy Policy, Term & Conditions, and Term of Service.";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
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
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  title(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  signupform(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: EdgeInsets.only(
                      right: 20,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                            activeColor: Colors.brown,
                            value: accept,
                            onChanged: (bool value) {
                              setState(() {
                                accept = value;
                              });
                            }),
                        Expanded(
                          child: Text(
                            tnc,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  submitButton('SUBMIT'),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: loginAccountLabel(),
                  ),
                ],
              ),
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
