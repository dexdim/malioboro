import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'auth/Auth.dart';
import 'Signup.dart';
import 'Forgot.dart';
import 'Menu.dart';

class Login extends StatefulWidget {
  Login({Key key, this.auth, this.loginCallback}) : super(key: key);

  final BaseAuth auth;
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
        userid = await widget.auth.signIn(email, password);

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

  Widget logo() {
    return Image(
      width: MediaQuery.of(context).size.width * 0.5,
      image: AssetImage('assets/icon/logomall.png'),
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
                fontSize: 16,
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
                    color: Colors.orangeAccent,
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
              child: Forgot(),
              type: PageTransitionType.fade,
              inheritTheme: true,
              ctx: context,
            ),
          );
        },
        child: Text(
          'Lupa password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.orangeAccent,
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
          color: Colors.orange[200],
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
          MaterialPageRoute(
            builder: (context) => Menu(),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.orange[100],
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
            'atau login dengan',
            style: TextStyle(fontSize: 16),
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
                    style: TextStyle(fontSize: 16),
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
                  style: TextStyle(fontSize: 16),
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
            'Anda belum punya akun? ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: SignUp(),
                  type: PageTransitionType.fade,
                  inheritTheme: true,
                  ctx: context,
                ),
              );
            },
            child: Text(
              'Daftar sekarang!',
              style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
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
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.6, 0.9],
                colors: [
                  Colors.white,
                  Color(0xffFED8B1),
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
