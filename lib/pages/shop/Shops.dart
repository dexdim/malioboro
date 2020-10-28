import 'package:flutter/material.dart';
import 'package:malioboromall/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';
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
  ShopsState() {
    searchQuery.addListener(
      () {
        if (searchQuery.text.isEmpty) {
          setState(
            () {
              searchText = '';
              isSearching = false;
              buildSearchList();
            },
          );
        } else {
          setState(
            () {
              searchText = searchQuery.text;
              isSearching = true;
              buildSearchList();
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    tenantData = ScopedModel.of<AppModel>(context).tenant;
    searchList = tenantData;
    isSearching = false;
  }

  final TextEditingController searchQuery = TextEditingController();
  DateTime currentBackPressTime;
  bool isSearching;
  String searchText = '';
  List<TenantList> tenantData;
  List<TenantList> searchList = List<TenantList>();
  List<TenantList> buildSearchList() {
    if (searchText.isEmpty || searchText == '') {
      return searchList = tenantData;
    } else {
      searchList = tenantData
          .where(
            (element) => element.nama.toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
          )
          .toList();
      print('${searchList.length} item found!');
      return searchList;
    }
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.brown,
    size: 30,
  );

  Widget appBarTitle = Text(
    'Choose the Store & Start Shopping!',
    style: TextStyle(
      fontSize: 22,
      shadows: [
        Shadow(
          offset: Offset(0.00, 2.00),
          color: Colors.brown.withOpacity(0.50),
          blurRadius: 5,
        ),
      ],
    ),
  );

  Widget appBar() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: appBarTitle,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 20,
                ),
                child: InkResponse(
                  child: searchIcon,
                  onTap: () {
                    if (this.searchIcon.icon == Icons.search) {
                      this.searchIcon = Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 26,
                      );
                      this.appBarTitle = Container(
                        margin: EdgeInsets.only(right: 5),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextField(
                          controller: searchQuery,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                            hintText: 'Search here...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.brown,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ),
                      );
                      handleSearchStart();
                    } else {
                      handleSearchEnd();
                    }
                  },
                ),
              ),
            ),
          ],
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
      content: Stack(
        children: [
          Positioned(
            top: -15,
            right: -35,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.brown,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                element.nama,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
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
              SizedBox(
                height: 20,
              ),
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
                    child: Image.network(
                      'https://malmalioboro.co.id/${element.image}',
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
        ],
      ),
    );
  }

  Widget itemImage(element, context) {
    return Container(
      width: MediaQuery.of(context).size.height / 9,
      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Image.network(
        'https://malmalioboro.co.id/${element.logo}',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget itemDetail(element) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            '${element.lokasi} FLOOR',
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
          Row(
            children: [
              Icon(
                Icons.local_phone_outlined,
                size: 16,
              ),
              Text(
                ' : ${element.telp2}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ImageIcon(
                AssetImage('assets/icon/whatsapp.png'),
                size: 16,
                color: Colors.green,
              ),
              Text(
                ' : ${element.telp}',
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

  Widget itemList(element) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => popupTenant(element),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        height: MediaQuery.of(context).size.height / 7,
        child: Row(
          children: [
            itemImage(element, context),
            VerticalDivider(),
            SizedBox(
              width: 10,
            ),
            itemDetail(element),
          ],
        ),
      ),
    );
  }

  void handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void handleSearchEnd() {
    setState(() {
      this.searchIcon = Icon(
        Icons.search,
        color: Colors.brown,
        size: 26,
      );
      this.appBarTitle = Text(
        'Choose the Store & Start Shopping!',
        style: TextStyle(
          fontSize: 22,
          shadows: [
            Shadow(
              offset: Offset(0.00, 2.00),
              color: Colors.brown.withOpacity(0.50),
              blurRadius: 5,
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    tenantData.sort((a, b) {
      return a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
    });

    return Column(
      children: [
        appBar(),
        Expanded(
          child: GroupedListView<dynamic, String>(
            shrinkWrap: true,
            elements: searchList,
            groupBy: (element) => element.kategori,
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) => item2.nama.compareTo(item1.nama),
            order: GroupedListOrder.DESC,
            groupSeparatorBuilder: (String value) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 10,
              ),
              child: Material(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            itemBuilder: (c, element) {
              return itemList(element);
            },
            separator: divider(),
          ),
        ),
      ],
    );
  }
}
