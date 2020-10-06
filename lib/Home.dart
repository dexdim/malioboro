import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/ScopeManage.dart';

class Home extends StatelessWidget {
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

  Widget news(context) {
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
          child: CachedNetworkImage(
            imageUrl:
                'http://www.malmalioboro.co.id/images/1530614179slide.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
      ),
    );
  }

  Widget carousel(context) {
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promo;

    final List<String> imgList = [
      'http://www.malmalioboro.co.id/assets/images/event/c0919d7d65b270c5a5b271879c41dc67.jpg',
      'http://www.malmalioboro.co.id/assets/images/event/c2c980a5ecf80da90b8892b7c58f3d1c.jpg',
      'http://www.malmalioboro.co.id/assets/images/event/7496914614f3b8d2fde970d2ba312016.jpg',
      'http://www.malmalioboro.co.id/assets/images/event/a9065cd8184ade854697311c43b2308a.jpg',
      'http://www.malmalioboro.co.id/assets/images/event/4cefe1787bcc5f8cae71c2cf768ab395.jpg'
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.25,
          viewportFraction: 0.5,
          autoPlay: true,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          enableInfiniteScroll: true,
          //enlargeCenterPage: true,
          pauseAutoPlayOnTouch: true,
        ),
        items: imgList
            .map(
              (url) => Container(
                padding: EdgeInsets.symmetric(vertical: 10),
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
                      imageUrl: url,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
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
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget listsocial(BuildContext context) {
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
              fontSize: 14,
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
            subtitle('News :'),
            news(context),
            divider(),
            subtitle('Highlight promos :'),
            carousel(context),
            divider(),
            subtitle('Upcoming events :'),
            SizedBox(height: 5),
            event(),
            divider(),
            subtitle('Find us on :'),
            listsocial(context)
          ],
        ),
      ),
    );
  }
}
