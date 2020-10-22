import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';

class DealDetail extends StatelessWidget {
  final int index;
  static final String route = 'DealDetail-route';

  DealDetail({this.index});

  @override
  Widget build(BuildContext context) {
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promo;

    return Scaffold(
      body: Container(
        child: Stack(
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
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'http://www.malmalioboro.co.id/${promoData[this.index].logo}',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          promoData[this.index].tenant,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
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
                          promoData[this.index].nama,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Available from ${promoData[index].tglawal} till ${promoData[index].tglakhir}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.brown,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a tincidunt elit. Aenean id feugiat metus. Suspendisse nulla leo, semper ut mauris quis, fringilla fringilla odio. Vivamus ac posuere diam. Nunc vel sagittis enim. Vivamus sed diam eu dui pulvinar egestas bibendum vel urna. Nullam et enim vel lectus posuere varius nec lobortis erat. Morbi maximus nulla eu venenatis varius. Fusce ac tempus lorem, quis rhoncus orci. Sed vel dictum mi, et vestibulum libero. Aenean a odio diam.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
