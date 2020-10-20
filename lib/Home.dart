import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Widget news() {
    return Container(
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
          child: Image.network(
            'http://malmalioboro.co.id/images/1530614179slide.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget carousel() => ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Container(
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
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              viewportFraction: 0.5,
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

  Widget event() {
    return Column(
      children: <Widget>[
        listevent('Event 1', 'Maret 2020', 'April 2020'),
        listevent('Event 2', 'Maret 2020', 'April 2020'),
        listevent('Event 3', 'Maret 2020', 'April 2020'),
        listevent('Event 4', 'Maret 2020', 'April 2020'),
        listevent('Event 5', 'Maret 2020', 'April 2020'),
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
          style: TextStyle(fontSize: 16),
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

  Widget listevent(String eventTitle, String tglawal, String tglakhir) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.event_available,
            color: Colors.redAccent,
          ),
          Text(
            '$eventTitle, $tglawal - $tglakhir',
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
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
            listsocial()
          ],
        ),
      ),
    );
  }
}
