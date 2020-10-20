import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:malioboromall/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';
import 'Catalog.dart';
import 'package:grouped_list/grouped_list.dart';

class Shops extends StatefulWidget {
  final AppModel appModel;
  static final String route = 'Catalog-route';

  Shops({this.appModel});

  @override
  ShopsState createState() => ShopsState();
}

class ShopsState extends State<Shops> {
  Widget button(element) {
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
        'CATALOGUE',
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

  Widget popupTenant(element) {
    Main.appModel.fetchData(element.id);

    return AlertDialog(
      title: Text(
        element.nama,
        textAlign: TextAlign.center,
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
                  imageUrl: 'https://malmalioboro.co.id/${element.image}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          button(element),
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

  Widget itemImage(element, context) {
    return Container(
      width: MediaQuery.of(context).size.height / 11,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Image.network(
        'https://malmalioboro.co.id/${element.logo}',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget itemDetail(element) {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            element.nama,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'LANTAI ${element.lokasi}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            element.kategori,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemList(element) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => popupTenant(element),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        height: MediaQuery.of(context).size.height / 9,
        child: Container(
          child: Row(
            children: [
              itemImage(element, context),
              itemDetail(element),
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
      child: GroupedListView<dynamic, String>(
        elements: tenantData,
        groupBy: (element) => element.kategori,
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) => item1.nama.compareTo(item2.nama),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        itemBuilder: (c, element) {
          return itemList(element);
        },
      ),
    );
  }
}