import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'model/ScopeManage.dart';
//import 'Home.dart';
//import 'Promo.dart';
import 'Tenants.dart';
import 'Profile.dart';
import 'auth/Auth.dart';

final List<String> imgList = [
  'http://www.malmalioboro.co.id/assets/images/event/c0919d7d65b270c5a5b271879c41dc67.jpg',
  'http://www.malmalioboro.co.id/assets/images/event/c2c980a5ecf80da90b8892b7c58f3d1c.jpg',
  'http://www.malmalioboro.co.id/assets/images/event/7496914614f3b8d2fde970d2ba312016.jpg',
  'http://www.malmalioboro.co.id/assets/images/event/a9065cd8184ade854697311c43b2308a.jpg',
  'http://www.malmalioboro.co.id/assets/images/event/4cefe1787bcc5f8cae71c2cf768ab395.jpg'
];

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

  Widget title() {
    return Text(
      'MALIOBORO MALL',
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
    );
  }

  Widget news() {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          child: Image.network(
            'http://www.malmalioboro.co.id/images/1530614179slide.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      ),
    );
  }

  Widget carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2,
        viewportFraction: 3,
        autoPlay: true,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        pauseAutoPlayOnTouch: true,
      ),
      items: imgList.map(
        (url) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Image.network(url),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget subtitle(String subtitle) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          '$subtitle',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
            shadows: [
              Shadow(
                offset: Offset(0.00, 2.00),
                color: Color(0xffd97c29).withOpacity(0.50),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  Widget event() {
    return Column(
      children: <Widget>[
        listevent('Event 1', 'Maret 2020 -  April 2020'),
        listevent('Event 2', 'Maret 2020 -  April 2020'),
        listevent('Event 3', 'Maret 2020 -  April 2020'),
        listevent('Event 4', 'Maret 2020 -  April 2020'),
        listevent('Event 5', 'Maret 2020 -  April 2020'),
      ],
    );
  }

  Widget socialbutton(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          child: InkWell(
            child: Image(
              image: AssetImage('assets/icon/$title.png'),
            ),
            onTap: () async {
              String url;
              if (title == 'Facebook') {
                url = 'https://facebook.com/MalioboroMall';
              } else if (title == 'Twitter') {
                url = 'https://twitter.com/malioboromall';
              } else if (title == 'Instagram') {
                url = 'https://instagram.com/malioboromall';
              }
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Tidak bisa membuka $title';
              }
            },
          ),
        ),
        Text(
          '$title',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget listsocial() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: socialbutton('Facebook'),
          ),
          Expanded(
            child: socialbutton('Twitter'),
          ),
          Expanded(
            child: socialbutton('Instagram'),
          ),
        ],
      ),
    );
  }

  Widget listevent(String eventTitle, String eventDate) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event_available,
            color: Colors.redAccent,
          ),
          Text(
            ' $eventTitle, $eventDate',
            style: TextStyle(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget promoImage(
    promoData,
    index,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl:
                  'http://www.malmalioboro.co.id/${promoData[index].logo}',
            ),
          ),
        ),
      ),
    );
  }

  Widget promoDetail(promoData, index) {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            promoData[index].tenant,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            promoData[index].nama,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.event,
                size: 16,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${promoData[index].tglawal} - ${promoData[index].tglakhir}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget promoList(promoData, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: MediaQuery.of(context).size.height / 6,
        child: Container(
          child: Row(
            children: [
              promoImage(promoData, index),
              promoDetail(promoData, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget home() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 5),
            //_subtitle('News :'),
            //_news(),
            divider(),
            subtitle('Highlight promo :'),
            carousel(),
            divider(),
            subtitle('Upcoming events :'),
            SizedBox(height: 5),
            event(),
            divider(),
            subtitle('Find us on :'),
            listsocial()
          ],
        ),
      ),
    );
  }

  Widget promo(promoData) {
    return Container(
      child: ListView.separated(
        itemCount: promoData.length,
        itemBuilder: (context, index) {
          return promoList(promoData, index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
            ),
          );
        },
      ),
    );
  }

  Widget pageView(promoData) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        home(),
        promo(promoData),
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
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promoListing;
    return Container(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: title(),
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
                  stops: [0.6, 0.9],
                  colors: [
                    Colors.white,
                    Color(0xffFED8B1),
                  ],
                ),
              ),
            ),
            pageView(promoData),
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
