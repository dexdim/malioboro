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
      children: [
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
              promoImage(
                promoData,
                index,
              ),
              promoDetail(
                promoData,
                index,
              ),
            ],
          ),
        ),
      ),
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
      ),
    );
  }
}
