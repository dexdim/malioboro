import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:malioboromall/auth/Auth.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget title() {
    return Text(
      'Sign Up',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 26,
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

  inputDecoration(String title) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(10),
      labelText: title,
      labelStyle: TextStyle(color: Colors.grey[850], fontSize: 18),
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
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget form(String title, controller, {bool isPassword = false}) {
    if (title == 'Email') {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          onSaved: (value) => title = value,
          decoration: inputDecoration(title),
          validator: (value) => !EmailValidator.validate(value, true)
              ? "Email isn't valid / still empty!"
              : null,
        ),
      );
    } else if (title == 'Password') {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 50,
        child: TextFormField(
          controller: controller,
          onSaved: (value) => title = value,
          style: TextStyle(
            fontSize: 18,
          ),
          obscureText: isPassword,
          decoration: inputDecoration(title),
          validator: (value) {
            if (value.isEmpty) {
              return '${title.toLowerCase()} is still empty!';
            } else if (value.length < 8) {
              return 'Passwords must have at lease 8 characters';
            }
            return null;
          },
        ),
      );
    } else
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 50,
        child: TextFormField(
          controller: controller,
          onSaved: (value) => title = value,
          style: TextStyle(
            fontSize: 18,
          ),
          obscureText: isPassword,
          decoration: inputDecoration(title),
          validator: (value) {
            if (value.isEmpty) {
              return '${title.toLowerCase()} is still empty!';
            } else if (value != passwordController.text) {
              return "Passwords doesn't match";
            } else
              return null;
          },
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
      onPressed: () async {
        SignInSignUpResult result = await Auth.signUp(
            email: emailController.text, password: passwordController.text);
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
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 500),
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

  Widget signupForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            form('Email', emailController),
            form('Password', passwordController, isPassword: true),
            form('Confirm Password', confirmController, isPassword: true),
          ],
        ),
      ),
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
                  signupForm(),
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
