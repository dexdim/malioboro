import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/ScopeManage.dart';

class Tenant extends StatefulWidget {
  @override
  TenantState createState() => TenantState();
}

class TenantState extends State<Tenant> {
  Widget _title() {
    return Column(
      children: [
        Text(
          'TENANTS',
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

  Widget itemImage(tenantData, index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: 'http://www.malmalioboro.co.id/${tenantData[index].logo}',
        ),
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'LANTAI ${tenantData[index].lokasi}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            tenantData[index].kategori,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemList(tenantData, index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: MediaQuery.of(context).size.height / 8,
        child: Container(
          child: Row(
            children: [
              itemImage(tenantData, index),
              itemDetail(tenantData, index),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TenantList> tenantData =
        ScopedModel.of<AppModel>(context).tenantListing;
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.separated(
          itemCount: tenantData.length,
          itemBuilder: (context, index) {
            return itemList(tenantData, index);
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
