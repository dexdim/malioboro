import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/ScopeManage.dart';

class Promo extends StatefulWidget {
  @override
  _PromoState createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  Widget _title() {
    return Column(
      children: <Widget>[
        Text(
          'PROMOS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            shadows: [
              Shadow(
                offset: Offset(0.00, 2.00),
                color: Colors.orangeAccent.withOpacity(0.50),
                blurRadius: 5,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promoListing;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
            itemCount: promoData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: MediaQuery.of(context).size.height / 6,
                  child: Container(
                    child: Row(children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://www.malmalioboro.co.id/${promoData[index].logo}',
                        ),
                      ),
                      VerticalDivider(
                        width: 30,
                        thickness: 1,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                              children: <Widget>[
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
                      ),
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
