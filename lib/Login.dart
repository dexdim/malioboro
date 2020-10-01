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
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(
      () {
        _errorMessage = "";
        _isLoading = true;
      },
    );

    if (validateAndSave()) {
      String userid = "";
      try {
        userid = await widget.auth.signIn(_email, _password);

        setState(() {
          _isLoading = false;
        });

        if (userid.length > 0 && userid != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  Widget _logo() {
    return Image(
      width: MediaQuery.of(context).size.width * 0.5,
      image: AssetImage('assets/icon/logomall.png'),
    );
  }

  Widget _loginform() {
    return Column(
      children: <Widget>[
        _form("Email"),
        _form("Password", isPassword: true),
      ],
    );
  }

  Widget _form(String title, {bool isPassword = false}) {
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

  Widget _forgotPassword() {
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

  Widget _loginButton() {
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

  Widget _divider() {
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

  Widget _socialLogin() {
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

  Widget _createAccount() {
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
    if (_isLoading) {
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
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
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
        children: <Widget>[
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
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  _logo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  _loginform(),
                  _forgotPassword(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  _loginButton(),
                  _divider(),
                  _socialLogin(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccount(),
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
