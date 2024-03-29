import 'package:flutter/material.dart';
import 'package:malioboromall/auth/Auth.dart';
import 'package:malioboromall/pages/Menu.dart';
import 'package:page_transition/page_transition.dart';
import 'Signup.dart';
import 'Forgot.dart';

class Login extends StatefulWidget {
  Login({Key key, this.auth, this.loginCallback}) : super(key: key);

  final Auth auth;
  final VoidCallback loginCallback;
  static final String route = 'Login-route';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;
  String errorMessage;
  bool isLoading;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(
      () {
        errorMessage = "";
        isLoading = true;
      },
    );

    if (validateAndSave()) {
      String userid = "";
      try {
        //userid = await widget.auth.signIn(email: email, password: password);

        setState(() {
          isLoading = false;
        });

        if (userid.length > 0 && userid != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error $e');
        setState(() {
          isLoading = false;
          errorMessage = e.message;
          formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    errorMessage = "";
    isLoading = false;
    super.initState();
  }

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

  Widget logo() {
    return Image(
      height: MediaQuery.of(context).size.height * 0.15,
      image: AssetImage('assets/icon/coklat.png'),
    );
  }

  Widget loginform() {
    return Column(
      children: <Widget>[
        form("Email"),
        form("Password", isPassword: true),
      ],
    );
  }

  Widget form(String title, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 1,
              validator: (value) =>
                  value.isEmpty ? '$title can\'t be empty' : null,
              onSaved: (value) => title = value.trim(),
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
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 500),
              child: Forgot(),
              type: PageTransitionType.fade,
              inheritTheme: true,
              ctx: context,
            ),
          );
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
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
        'LOGIN',
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

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(
            'or login with',
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }

  Widget socialLogin() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.30,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    child: Image(
                      image: AssetImage('assets/icon/Facebook.png'),
                    ),
                  ),
                  Text(
                    'Facebook',
                    style: TextStyle(fontSize: 18),
                  ),
                ]),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: AssetImage('assets/icon/Google.png'),
                  ),
                ),
                Text(
                  'Google',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createAccount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account yet? ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 500),
                  child: SignUp(),
                  type: PageTransitionType.fade,
                  inheritTheme: true,
                  ctx: context,
                ),
              );
            },
            child: Text(
              'Sign up now!',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showCircularProgress() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget showErrorMessage() {
    if (errorMessage.length > 0 && errorMessage != null) {
      return new Text(
        errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.8],
                colors: [
                  Colors.white,
                  Color(0xfffee18e),
                ],
              ),
            ),
            key: formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  loginform(),
                  forgotPassword(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  loginButton(),
                  divider(),
                  socialLogin(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: createAccount(),
                  ),
                ],
              ),
            ),
          ),
          showCircularProgress(),
        ],
      ),
    );
  }
}
