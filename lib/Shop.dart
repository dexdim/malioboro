import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:malioboromall/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';
import 'Catalog.dart';

class Shop extends StatefulWidget {
  //final AppModel appModel = AppModel();
  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<Shop> {
  Widget button(tenantData, index) {
    return RaisedButton(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.brown,
          width: 1,
        ),
      ),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 50,
      ),
      child: Text(
        'BROWSE KATALOG',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Catalog(
              appModel: Main.appModel,
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Color(0xfffee18e),
    );
  }

  Widget popupTenant(tenantData, index) {
    Main.appModel.fetchData(tenantData[index].id);

    return AlertDialog(
      title: Text(
        tenantData[index].nama,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                child: CachedNetworkImage(
                  imageUrl:
                      'https://malmalioboro.co.id/${tenantData[index].image}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          button(tenantData, index),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget itemImage(tenantData, index, context) {
    return Container(
      width: MediaQuery.of(context).size.height / 11,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Image.network(
        'https://malmalioboro.co.id/${tenantData[index].logo}',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget itemDetail(tenantData, index) {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tenantData[index].nama,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'LANTAI ${tenantData[index].lokasi}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            tenantData[index].kategori,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemList(tenantData, index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => popupTenant(tenantData, index),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        height: MediaQuery.of(context).size.height / 9,
        child: Container(
          child: Row(
            children: [
              itemImage(tenantData, index, context),
              itemDetail(tenantData, index),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TenantList> tenantData = ScopedModel.of<AppModel>(context).tenant;

    tenantData.sort((a, b) {
      return a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
    });

    return Container(
      child: ListView.separated(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        itemCount: tenantData.length,
        itemBuilder: (context, index) {
          return itemList(tenantData, index);
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
    );
  }
}
