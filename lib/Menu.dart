import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home.dart';
import 'Promo.dart';
import 'Tenant.dart';
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
  String titleText = 'MALIOBORO MALL';
  String subtitleText = '';
  bool visible = false;
  DateTime currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  Widget title(titleText) {
    return Column(
      children: [
        Text(
          titleText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            shadows: [
              Shadow(
                offset: Offset(0.00, 2.00),
                color: Colors.orangeAccent.withOpacity(0.50),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: Text(
            subtitleText,
            style: TextStyle(fontSize: 16),
          ),
        ),
        divider(),
      ],
    );
  }

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
    setState(
      () {
        if (index == 0) {
          titleText = 'MALIOBORO MALL';
          subtitleText = '';
          visible = false;
        } else if (index == 1) {
          titleText = 'PROMOS';
          subtitleText = 'here is our great deal, grab it fast';
          visible = true;
        } else if (index == 2) {
          titleText = 'TENANTS';
          subtitleText = 'meet our special tenants';
          visible = true;
        } else if (index == 3) {
          titleText = 'PROFILE';
          subtitleText = 'hello customer!';
          visible = true;
        }
        selectedIndex = index;
        pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: title(titleText),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.4, 0.8],
                  colors: [
                    Colors.white,
                    Color(0xffFED8B1),
                  ],
                ),
              ),
            ),
            pageView(),
            Positioned(
              left: 10,
              bottom: 10,
              right: 10,
              child: bottomBar(),
            ),
          ],
        ),
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
        CustomNavigationBarItem(icon: Icons.home_outlined),
        CustomNavigationBarItem(icon: Icons.local_mall_outlined),
        CustomNavigationBarItem(icon: Icons.storefront_outlined),
        CustomNavigationBarItem(icon: Icons.account_box_outlined),
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
