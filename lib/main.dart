import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'auth/Auth.dart';
import 'model/ScopeManage.dart';
import 'Login.dart';
import 'Menu.dart';
import 'Root.dart';

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
    Menu.route: (BuildContext context) => Menu(),
  };

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    if (useWhiteForeground(Colors.white)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }

    return ScopedModel<AppModel>(
      model: appModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Malioboro Mall',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Poppins',
        ),
        //home: Menu(),
        home: Root(
          auth: Auth(),
        ),
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
        builder: (context) => Menu(),
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
          'assets/logo.png',
        ),
      ),
    );
  }
}
