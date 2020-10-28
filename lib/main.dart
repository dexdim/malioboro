import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malioboromall/model/AppScope.dart';
import 'package:malioboromall/pages/Menu.dart';
import 'package:malioboromall/pages/profile/EditProfile.dart';
import 'package:malioboromall/pages/shop/Cart.dart';
import 'package:malioboromall/pages/shop/Catalog.dart';
import 'package:malioboromall/pages/shop/Detail.dart';
import 'package:malioboromall/pages/shop/Forms.dart';
import 'package:malioboromall/pages/user/Change.dart';
import 'package:malioboromall/pages/user/Forgot.dart';
import 'package:malioboromall/pages/user/Login.dart';
import 'package:malioboromall/pages/user/Signup.dart';
import 'package:scoped_model/scoped_model.dart';
import 'auth/Auth.dart';
import 'auth/Root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  static final AppModel appModel = AppModel();
  final Future<FirebaseApp> initialize = Firebase.initializeApp();

  final routes = <String, WidgetBuilder>{
    Login.route: (BuildContext context) => Login(),
    SignUp.route: (BuildContext context) => SignUp(),
    Forgot.route: (BuildContext context) => Forgot(),
    Menu.route: (BuildContext context) => Menu(),
    Catalog.route: (BuildContext context) => Catalog(),
    Detail.route: (BuildContext context) => Detail(),
    Cart.route: (BuildContext context) => Cart(),
    Forms.route: (BuildContext context) => Forms(),
    EditProfile.route: (BuildContext context) => EditProfile(),
    Change.route: (BuildContext context) => Change(),
  };

  Widget error() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Something went wrong, please contact developers.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget loading() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(
      Color(0xfffee18e),
    );
    if (useWhiteForeground(Colors.transparent)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }

    return FutureBuilder(
      future: initialize,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return error();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ScopedModel<AppModel>(
            model: appModel,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Malioboro Mall Shop & Deals',
              theme: ThemeData(
                primaryColor: Colors.white,
                textTheme: GoogleFonts.nunitoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: Splash(),
              routes: routes,
            ),
          );
        }
        return loading();
      },
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
    return Stack(
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
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(30.0),
            width: 200.0,
            child: Image.asset(
              'assets/icon/coklat.png',
            ),
          ),
        ),
      ],
    );
  }
}
