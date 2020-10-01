import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/ScopeManage.dart';

class Tenant extends StatefulWidget {
  @override
  _TenantState createState() => _TenantState();
}

class _TenantState extends State<Tenant> {
  Widget _title() {
    return Text(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TenantList> tenantData =
        ScopedModel.of<AppModel>(context).tenantListing;

    var size = MediaQuery.of(context).size;
    final double listHeight = (size.height - kToolbarHeight + 200) / 3.5;
    final double listWidth = size.width;
    final double aspectRatio = listWidth / listHeight;

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
        child: Padding(
          padding: EdgeInsets.all(5),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: aspectRatio),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl:
                                'http://malmalioboro.co.id/${tenantData[index].logo}',
                            fit: BoxFit.fill,
                          ),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tenantData[index].nama.toString(),
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
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: tenantData.length,
          ),
        ),
      ),
    );
  }
}
