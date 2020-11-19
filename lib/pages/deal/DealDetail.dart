import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';

class DealDetail extends StatelessWidget {
  final int index;
  static final String route = 'DealDetail-route';

  DealDetail({this.index});

  @override
  Widget build(BuildContext context) {
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promo;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Scaffold(
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
              Column(
                children: [
                  Container(
                    child: Image.network(
                      'http://www.malmalioboro.co.id/${promoData[this.index].logo}',
                      width: MediaQuery.of(context).size.width,
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
                              fontSize: 20,
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
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${promoData[index].tglawal} till ${promoData[index].tglakhir}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${promoData[index].deskripsi} ',
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
      ),
    );
  }
}
