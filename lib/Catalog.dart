import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/CatalogScope.dart';
import 'Cart.dart';
import 'Details.dart';

class Catalog extends StatefulWidget {
  final CatalogModel catalogModel = CatalogModel();
  static final String route = 'Catalog-route';

  @override
  CatalogState createState() => CatalogState();
}

class CatalogState extends State<Catalog> {
  static final CatalogModel catalogModel = CatalogModel();
  CatalogState() {
    searchQuery.addListener(() {
      if (searchQuery.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = null;
          buildSearchList();
        });
      } else {
        setState(() {
          isSearching = true;
          searchText = searchQuery.text;
          buildSearchList();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isSearching = false;
    data = ScopedModel.of<CatalogModel>(context).itemListing;
    searchList = data;
  }

  // TODO: Implement Build

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = TextEditingController();
  DateTime currentBackPressTime;
  bool isSearching;
  String searchText = '';
  List<Data> data;
  List<Data> searchList = List();
  List<Data> buildSearchList() {
    if (searchText.isEmpty) {
      return searchList = data;
    } else {
      searchList = data
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

  Widget itemImage(index) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: 'http://www.malmalioboro.co.id/${searchList[index].gambar}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget itemName(index) {
    return Text(
      '${searchList[index].nama}',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  Widget itemPrice(index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.orange[200],
            thickness: 1,
          ),
          Row(
            children: <Widget>[
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  name: 'Rp ',
                  decimalDigits: 0,
                ).format(searchList[index].harga),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.orangeAccent,
    size: 30,
  );

  Widget appBarTitle = Text(
    'SUPERMARKET MALIOBORO MALL',
    style: TextStyle(
      fontSize: 20,
    ),
  );

  Widget cartButton() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.orangeAccent,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Cart(),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          Positioned(
            top: 5,
            left: 30,
            child: ScopedModelDescendant<CatalogModel>(
              builder: (context, child, model) {
                return Container(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    (model.cartListing.length > 0)
                        ? model.cartListing.length.toString()
                        : '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: appBarTitle,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: InkResponse(
            child: searchIcon,
            onTap: () {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 25,
                );
                this.appBarTitle = Container(
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: searchQuery,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      hintText: 'Cari di sini...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
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
      ],
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
        color: Colors.orangeAccent,
        size: 30,
      );
      this.appBarTitle = Text(
        'SUPERMARKET MALIOBORO MALL',
        style: TextStyle(
          fontSize: 20,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight + 50) / 3.5;
    final double itemWidth = size.width / 3;
    final double aspectRatio = itemWidth / itemHeight;

    return ScopedModel<CatalogModel>(
      model: catalogModel,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(context),
        body: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: aspectRatio),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Details(detail: searchList[index]),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.orange[200]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          itemImage(index),
                          itemName(index),
                          itemPrice(index),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: searchList.length,
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 5, bottom: 5),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 3),
              shape: BoxShape.circle),
          child: cartButton(),
        ),
      ),
    );
  }
}
