import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';
import 'Cart.dart';
import 'Detail.dart';

class Catalog extends StatefulWidget {
  final AppModel appModel;
  static final String route = 'Catalog-route';

  Catalog({this.appModel});

  @override
  CatalogState createState() => CatalogState();
}

class CatalogState extends State<Catalog> {
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
    data = ScopedModel.of<AppModel>(context).catalog;
    searchList.clear();
    searchList = data;
    isSearching = false;
  }

  // TODO: Implement Build
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchQuery = TextEditingController();
  DateTime currentBackPressTime;
  bool isSearching;
  String searchText = '';
  List<Data> data;
  List<Data> searchList = List<Data>();
  List<Data> buildSearchList() {
    if (searchText.isEmpty || searchText == '') {
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
      height: 150,
      width: 150,
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Image.network(
            'http://www.malmalioboro.co.id/${searchList[index].gambar}',
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }

  Widget itemName(index) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Flexible(
          child: Container(
            child: Text(
              '${searchList[index].nama}',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemPrice(index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.brown[200],
            thickness: 1,
          ),
          Text(
            '${NumberFormat.currency(
              locale: 'id',
              name: 'Rp ',
              decimalDigits: 0,
            ).format(searchList[index].harga)},-',
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.brown,
    size: 26,
  );

  Widget appBarTitle = Text(
    'Catalogue',
    style: TextStyle(
      fontSize: 18,
      shadows: [
        Shadow(
          offset: Offset(0.00, 2.00),
          color: Colors.brown.withOpacity(0.50),
          blurRadius: 5,
        ),
      ],
    ),
  );

  Widget cartButton() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.brown,
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
            child: ScopedModelDescendant<AppModel>(
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
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15),
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
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: searchQuery,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
        color: Colors.brown,
        size: 26,
      );
      this.appBarTitle = Text(
        'Catalogue',
        style: TextStyle(
          fontSize: 18,
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 5;
    final double itemWidth = size.width / 4;
    final double aspectRatio = itemWidth / itemHeight;

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.8],
                colors: [
                  Colors.white,
                  Color(0xfffee18e),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(detail: searchList[index]),
                          ),
                        );
                      },
                      child: Container(
                        height: 600,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.brown[200]),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
        ],
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
    );
  }
}
