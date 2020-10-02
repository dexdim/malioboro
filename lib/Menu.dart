import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home.dart';
import 'Promo.dart';
import 'Tenants.dart';
import 'Profile.dart';
import 'auth/Auth.dart';

class Menu extends StatefulWidget {
  Menu({Key key, this.auth, this.userid, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final String userid;
  final VoidCallback logoutCallback;
  static final String route = 'Menu-route';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
        Tenant(),
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
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            pageView(),
            Positioned(
              left: 10,
              bottom: 10,
              right: 10,
              child: bottomBar(),
            ),
          ],
        ),
        //bottomNavigationBar: bottomBar(),
      ),
    );
  }

  Widget bottomBar() {
    return CustomNavigationBar(
      isFloating: true,
      iconSize: 30.0,
      selectedColor: Colors.orangeAccent,
      strokeColor: Colors.orangeAccent,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.white,
      borderRadius: Radius.circular(20.0),
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
          pageController.jumpToPage(
            index,
          );
        });
      },
      items: [
        CustomNavigationBarItem(icon: Icons.home),
        CustomNavigationBarItem(icon: Icons.monetization_on),
        CustomNavigationBarItem(icon: Icons.local_mall),
        CustomNavigationBarItem(icon: Icons.account_circle),
      ],
    );
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
