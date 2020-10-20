import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Home.dart';
import 'Deal.dart';
import 'Shop.dart';
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
  String subtitleText = 'shop & deals';
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
                color: Colors.brown.withOpacity(0.50),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        Text(
          subtitleText,
          style: TextStyle(fontSize: 18),
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
        Shop(),
        Deal(),
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
          subtitleText = 'shop & deals';
        } else if (index == 1) {
          titleText = 'SHOPS';
          subtitleText = 'check our tenants and their hot items';
        } else if (index == 2) {
          titleText = 'DEALS';
          subtitleText = 'special offers for you, grab it fast';
        } else if (index == 3) {
          titleText = 'PROFILE';
          subtitleText = 'hello customer!';
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
      iconSize: 30.0,
      selectedColor: Colors.brown,
      strokeColor: Colors.brown,
      unSelectedColor: Color(0xfffee18e),
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
