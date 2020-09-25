import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malioboromall/model/ScopeManage.dart';
import 'auth/Auth.dart';
import 'main.dart';
import 'Home.dart';
import 'Promo.dart';
import 'Tenant.dart';
import 'Profile.dart';
//import 'package:firebase_database/firebase_database.dart';

class Menu extends StatefulWidget {
  Menu({Key key, this.auth, this.userid, this.logoutCallback, this.appModel})
      : super(key: key);
  final AppModel appModel;
  final BaseAuth auth;
  final String userid;
  final VoidCallback logoutCallback;
  static final String route = 'Menu-route';

  @override
  State<StatefulWidget> createState() {
    return MenuState();
  }
  //_MenuState createState() => _MenuState();
}

class MenuState extends State<Menu> {
  //final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int selectedIndex = 0;
  DateTime currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget pageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Home(),
        Promo(),
        Tenant(
          appModel: Main.appModel,
        ),
        Profile(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 100), curve: Curves.ease);
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(body: pageView(), bottomNavigationBar: bottomItems()));
  }

  FFNavigationBar bottomItems() {
    return FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.orangeAccent,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.orangeAccent,
          unselectedItemIconColor: Colors.black,
          unselectedItemLabelColor: Colors.black,
          barHeight: 50,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          bottomTapped(index);
        },
        items: [
          FFNavigationBarItem(label: 'Home', iconData: Icons.home),
          FFNavigationBarItem(label: 'Promos', iconData: Icons.monetization_on),
          FFNavigationBarItem(label: 'Tenants', iconData: Icons.store),
          FFNavigationBarItem(label: 'Profile', iconData: Icons.account_circle),
        ]);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) >
            Duration(
              seconds: 2,
            )) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tekan tombol kembali sekali lagi untuk keluar.');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
