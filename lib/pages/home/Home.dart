import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:malioboromall/pages/deal/DealDetail.dart';
import 'package:malioboromall/pages/home/News.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget appBar(title) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/icon/logo_gold.png',
          height: 50,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                offset: Offset(0.00, 2.00),
                color: Colors.brown.withOpacity(0.50),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        divider(),
      ],
    );
  }

  Widget news() {
    List<String> image = [
      'assets/news.jpg',
      'assets/news2.jpg',
      'assets/news3.jpg',
    ];
    return CarouselSlider(
      items: image
          .map(
            (item) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => News(),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 4.5,
                width: MediaQuery.of(context).size.width * 0.8,
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
                    child: Image.asset(
                      item,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        aspectRatio: 21 / 9,
        viewportFraction: 1,
      ),
    );
  }

  Widget carousel() => ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DealDetail(
                    index: index,
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    child: Image.network(
                      'https://malmalioboro.co.id/${model.promo[index].logo}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              viewportFraction: 0.4,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              enableInfiniteScroll: true,
              pauseAutoPlayOnTouch: true,
            ),
          ),
        ),
      );

  Widget subtitle(String subtitle) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 40),
        child: Text(
          '$subtitle',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
            shadows: [
              Shadow(
                offset: Offset(0.00, 2.00),
                color: Colors.brown.withOpacity(0.50),
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
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Divider(
        thickness: 1,
      ),
    );
  }

  Widget popupEvent() {
    return AlertDialog(
      content: Stack(
        children: [
          Positioned(
            top: -15,
            right: -35,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.brown,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Malioboro Mall Foodstival',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      offset: Offset(0.00, 2.00),
                      color: Colors.brown.withOpacity(0.50),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      'http://www.malmalioboro.co.id/assets/images/event/8d887a83900a3d80f797e2d08d4bb63f.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Event date : 14 July 2020 - 31 July 2020',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listevent(String eventTitle, String tglawal, String tglakhir) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => popupEvent(),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 5,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.event_available,
              color: Colors.redAccent,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '$eventTitle, $tglawal - $tglakhir',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget event() {
    return Column(
      children: <Widget>[
        listevent('Malioboro Mall Foodstival', '14 July 2020', '31 July 2020'),
        listevent('Event 2', 'Oktober 2020', 'November 2020'),
        listevent('Event 3', 'Oktober 2020', 'November 2020'),
        listevent('Event 4', 'Oktober 2020', 'November 2020'),
        listevent('Event 5', 'Oktober 2020', 'November 2020'),
      ],
    );
  }

  Widget socialButton(String title) {
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
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget listSocial() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: socialButton('Facebook'),
          ),
          Expanded(
            child: socialButton('Twitter'),
          ),
          Expanded(
            child: socialButton('Instagram'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          appBar('Hi User!\nWelcome to Malioboro Mall - Shop & Deals'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  news(),
                  divider(),
                  subtitle('Top Picks for You :'),
                  carousel(),
                  divider(),
                  subtitle('Events & Exhibitions :'),
                  SizedBox(height: 5),
                  event(),
                  divider(),
                  subtitle('Connect with Us :'),
                  listSocial()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
