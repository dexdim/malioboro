import 'package:flutter/material.dart';
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
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

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

  Widget _form(String title, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            child: TextFormField(
                autofocus: false,
                maxLines: 1,
                validator: (value) =>
                    value.isEmpty ? '$title can\'t be empty' : null,
                onSaved: (value) => title = value.trim(),
                style: TextStyle(color: Color(0xff333333), fontSize: 16),
                obscureText: isPassword,
                decoration: InputDecoration(
                    fillColor: Color(0xfffffff),
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

  Widget _loginButton() {
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
        'LOGIN',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff333333),
        ),
      ),
      //onPressed: validateAndSubmit,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Menu()));
      },
      splashColor: Color.fromRGBO(214, 114, 25, 90),
      highlightColor: Colors.transparent,
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('atau login dengan', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _socmedButton() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                      alignment: Alignment.center,
                      child:
                          Image(image: AssetImage('assets/icon/Facebook.png'))),
                  Text(
                    'Facebook',
                    style: TextStyle(fontSize: 16),
                  ),
                ]),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/icon/Google.png'),
                      )),
                  Text(
                    'Google',
                    style: TextStyle(fontSize: 16),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
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
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xffD67219),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget _logo() {
    return Image(
      width: MediaQuery.of(context).size.width / 2,
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

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
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
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.6, 0.9],
                    colors: [Colors.white, Color(0xffFED8B1)])),
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                _logo(),
                SizedBox(
                  height: 100,
                ),
                _loginform(),
                Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Forgot()));
                      },
                      child: Text('Lupa password?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffD67219))),
                    )),
                SizedBox(
                  height: 30,
                ),
                _loginButton(),
                _divider(),
                _socmedButton(),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _createAccountLabel(),
          ),
          showCircularProgress(),
        ],
      ),
    )));
  }
}
