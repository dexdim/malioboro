import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'auth/Auth.dart';
import 'model/AppScope.dart';
import 'Login.dart';
import 'Signup.dart';
import 'Forgot.dart';
import 'Menu.dart';
import 'Root.dart';
import 'Catalog.dart';
import 'Detail.dart';
import 'Cart.dart';
import 'Forms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  static final AppModel appModel = AppModel();

  final routes = <String, WidgetBuilder>{
    Login.route: (BuildContext context) => Login(),
    SignUp.route: (BuildContext context) => SignUp(),
    Forgot.route: (BuildContext context) => Forgot(),
    Menu.route: (BuildContext context) => Menu(),
    Catalog.route: (BuildContext context) => Catalog(),
    Detail.route: (BuildContext context) => Detail(),
    Cart.route: (BuildContext context) => Cart(),
    Forms.route: (BuildContext context) => Forms(),
  };

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    if (useWhiteForeground(Colors.transparent)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }

    FlutterStatusbarcolor.setNavigationBarColor(
      Color(0xfffee18e),
    );
    if (useWhiteForeground(Colors.transparent)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }

    return ScopedModel<AppModel>(
      model: appModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Malioboro Mall Shop & Deals',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Baloo2',
        ),
        //home: Menu(),
        home: Splash(),

        routes: routes,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  final String title;
  Splash({Key key, this.title}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Root(
          auth: Auth(),
        ),
      ),
    );
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    this.startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        margin: EdgeInsets.all(30.0),
        width: 300.0,
        child: Image.asset(
          'assets/icon/coklat.png',
        ),
      ),
    );
  }
}
