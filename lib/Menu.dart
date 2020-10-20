import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Home.dart';
import 'Deal.dart';
import 'Shops.dart';
import 'Cart.dart';
import 'Profile.dart';
import 'auth/Auth.dart';
import 'model/AppScope.dart';

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
  dynamic titles = Image.asset(
    'assets/icon/logo_gold.png',
    width: 100,
  );
  String subtitleText = 'hi User! Welcome to Malioboro Mall - Shop & Deals';
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
        Shops(),
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
          titles = Image.asset(
            'assets/icon/logo_gold.png',
            width: 100,
          );
          subtitleText = 'hi User! Welcome to Malioboro Mall - Shop & Deals';
        } else if (index == 1) {
          titles = '';
          subtitleText = 'choose the store & start shopping';
        } else if (index == 2) {
          titles = 'DEALS';
          subtitleText = 'deals spesial buat kamu';
        } else if (index == 3) {
          titles = 'PROFILE';
          subtitleText = 'hai customer!';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: title(titles),
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
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 5, bottom: 60),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 3),
              shape: BoxShape.circle),
          child: cartButton(),
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
