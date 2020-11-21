import 'package:flutter/material.dart';
import 'package:malioboromall/pages/deal/DealDetail.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';

class Deal extends StatefulWidget {
  @override
  DealState createState() => DealState();
}

class DealState extends State<Deal> {
  List<PromoList> promoData;

  Widget appBar(title) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
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

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Divider(
        thickness: 1,
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
          child: Image.network(
            'http://www.malmalioboro.co.id/${promoData[index].logo}',
            fit: BoxFit.fill,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            promoData[index].tenant,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            promoData[index].nama,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.event,
                size: 14,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  '${promoData[index].tglawal} - ${promoData[index].tglakhir}',
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DealDetail(
            index: index,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: MediaQuery.of(context).size.height / 5,
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

  @override
  void initState() {
    super.initState();
    promoData = ScopedModel.of<AppModel>(context).promo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBar('Get Special Discount & Deals!'),
        Expanded(
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
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Divider(
                  thickness: 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
