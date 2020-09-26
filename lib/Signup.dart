import 'package:flutter/material.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool accept = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 3),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }

  Widget _form(String title, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: TextFormField(
                onSaved: (value) => title = value,
                style: TextStyle(color: Color(0xff333333), fontSize: 16),
                obscureText: isPassword,
                decoration: InputDecoration(
                    fillColor: Color(0xffffffff),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: title,
                    labelStyle: TextStyle(color: Color(0xff333333)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffaaaaaa)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD67219)),
                    ),
                    filled: true)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _submitButton(String title) {
    return RaisedButton(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.00),
        side: BorderSide(
          color: Color(0xffd67219),
          width: 1,
        ),
      ),
      color: Color(0xffffffff),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 70,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff333333),
        ),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      splashColor: Color.fromRGBO(214, 114, 25, 90),
      highlightColor: Colors.transparent,
    );
  }

  Widget _loginAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sudah mempunyai akun? ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ));
  }

  Widget _signupform() {
    return Column(
      children: <Widget>[
        _form("Nama Lengkap"),
        _form("Email"),
        _form("Password", isPassword: true),
        _form("Konfirmasi Password", isPassword: true),
      ],
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "DAFTAR AKUN",
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 40,
                left: 0,
                child: _backButton(),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.6, 0.9],
                        colors: [Colors.white, Color(0xfffed8b1)])),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _signupform(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 30, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: accept,
                              onChanged: (bool value) {
                                setState(() {
                                  accept = value;
                                });
                              }),
                          Expanded(
                              child: Text(
                                  'Dengan ini saya telah membaca dan menyetujui Mal Malioboro Terms and Conditions, Privacy Policy, dan Terms of Service.',
                                  textAlign: TextAlign.justify)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _submitButton('SUBMIT'),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _loginAccountLabel(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
