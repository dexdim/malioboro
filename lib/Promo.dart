import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/ScopeManage.dart';

class Promo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PromoList> promoData = ScopedModel.of<AppModel>(context).promoListing;

    return Container(
      child: ListView.separated(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        itemCount: promoData.length,
        itemBuilder: (context, index) {
          return promoList(promoData, index, context);
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

  Widget promoImage(promoData, index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 20),
      width: MediaQuery.of(context).size.height / 6,
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
            imageUrl: 'http://www.malmalioboro.co.id/${promoData[index].logo}',
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

  Widget promoList(promoData, index, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: MediaQuery.of(context).size.height / 6,
        child: Container(
          child: Row(
            children: [
              promoImage(promoData, index, context),
              promoDetail(promoData, index),
            ],
          ),
        ),
      ),
    );
  }
}
