import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malioboromall/model/AppScope.dart';
import 'Forms.dart';

class Cart extends StatefulWidget {
  static final String route = 'Cart-route';

  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static var totalHarga;

  Widget button(String title, int d) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.brown[200],
                  width: 1,
                ),
              ),
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 50,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                print(d);
                Timer(Duration(milliseconds: 500), () {
                  if (model.cartListing.length == 0) {
                    showCartSnak(model.cartEmpty);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Forms(
                                id: d,
                              )),
                    );
                  }
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Color(0xfffee18e),
            )
          ],
        );
      },
    );
  }

  Widget generateCart(Data d) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          border: Border(
            bottom: BorderSide(color: Colors.grey[100], width: 1.0),
            top: BorderSide(color: Colors.grey[100], width: 1.0),
          ),
        ),
        height: 150.0,
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)],
                image: DecorationImage(
                    image: NetworkImage(
                        'http://www.malmalioboro.co.id/${d.gambar}'),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            d.nama,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ScopedModelDescendant<AppModel>(
                            builder: (context, child, model) {
                              return InkResponse(
                                onTap: () {
                                  print(d.idtenan);
                                  model.removeCart(d, d.idtenan);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(children: <Widget>[
                        Text(
                          'Total : ',
                          style: TextStyle(fontSize: 16),
                        ),
                        counterBar(d.counter),
                      ]),
                    ),
                    Expanded(
                      child: Text(
                        'Price : ${NumberFormat.currency(
                          locale: 'id',
                          name: 'Rp ',
                          decimalDigits: 0,
                        ).format(d.harga)},-',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Subtotal price : ${NumberFormat.currency(
                          locale: 'id',
                          name: 'Rp ',
                          decimalDigits: 0,
                        ).format(d.subtotal)},-',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget counterBar(int counter) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          setState(() {
            counter -= 1;
            if (counter < 1) {
              counter = 1;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.brown[200]),
          ),
          child: Icon(
            Icons.remove,
            size: 10,
          ),
        ),
      ),
      SizedBox(width: 15),
      Text(
        "$counter",
        style: TextStyle(fontSize: 15),
      ),
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          setState(() {
            counter += 1;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.brown[200]),
          ),
          child: Icon(
            Icons.add,
            size: 10,
          ),
        ),
      ),
    ]);
  }

  Widget totalBar() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 110,
            child: Text(
              'Total price :',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.brown,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$totalHarga,-',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  showCartSnak(String msg) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[500],
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Your Shopping List!',
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
        ),
        centerTitle: true,
      ),
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
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
              ),
            ),
            child: ScopedModelDescendant<AppModel>(
              builder: (context, child, model) {
                return ListView(
                  shrinkWrap: true,
                  children: model.cartListing
                      .map(
                        (d) => generateCart(d),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xfffee18e),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 90,
          child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) {
              totalHarga = NumberFormat.currency(
                locale: 'id',
                name: 'Rp ',
                decimalDigits: 0,
              ).format(
                (model.cartListing
                    .fold(0, (total, current) => total + current.subtotal)),
              );

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  totalBar(),
                  SizedBox(
                    height: 10,
                  ),
                  button('ORDER', model.catalog[0].idtenan),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
