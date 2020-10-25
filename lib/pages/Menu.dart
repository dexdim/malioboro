import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malioboromall/auth/Auth.dart';
import 'package:malioboromall/pages/deal/Deal.dart';
import 'package:malioboromall/pages/profile/Profile.dart';
import 'package:malioboromall/pages/shop/Cart.dart';
import 'package:malioboromall/pages/shop/Shops.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'home/Home.dart';
import 'package:malioboromall/model/AppScope.dart';

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
  bool visible = false;
  DateTime currentBackPressTime;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final List<Widget> body = [
    Home(),
    Shops(),
    Deal(),
    Profile(),
  ];

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget cartButton() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.brown,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Cart(),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          Positioned(
            top: 5,
            left: 30,
            child: ScopedModelDescendant<AppModel>(
              builder: (context, child, model) {
                return Container(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    (model.cartListing.length > 0)
                        ? model.cartListing.length.toString()
                        : '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return SalomonBottomBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.brown,
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
          if (selectedIndex == 1) {
            visible = true;
          } else {
            visible = false;
          }
          /*
          pageController.jumpToPage(
            index,
          );
          */
        });
      },
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text('Home'),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.local_mall_outlined),
          title: Text('Shops'),
        ),
        SalomonBottomBarItem(
          icon: ImageIcon(
            AssetImage(
              'assets/icon/deals.png',
            ),
          ),
          title: Text('Deals'),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.account_circle_outlined),
          title: Text('Profile'),
        ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        extendBody: true,
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
            body[selectedIndex],
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Material(
            elevation: 5,
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
            child: bottomBar(),
          ),
        ),
        floatingActionButton: Visibility(
          visible: visible,
          child: Container(
            margin: EdgeInsets.only(right: 5),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),
                shape: BoxShape.circle),
            child: cartButton(),
          ),
        ),
      ),
    );
  }
}
