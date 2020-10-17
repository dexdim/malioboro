import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/AppScope.dart';
import 'Forms.dart';

class Cart extends StatefulWidget {
  static final String route = 'Cart-route';

  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static var totalHarga;

  Widget button(String title) {
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
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Timer(Duration(milliseconds: 500), () {
                  if (model.cartListing.length == 0) {
                    showCartSnak(model.cartEmpty);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Forms(),
                      ),
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
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ScopedModelDescendant<AppModel>(
                            builder: (context, child, model) {
                              return InkResponse(
                                onTap: () {
                                  model.removeCart(d);
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
                          'Jumlah : ',
                          style: TextStyle(fontSize: 15),
                        ),
                        counterBar(d.counter),
                      ]),
                    ),
                    Row(children: <Widget>[
                      Text(
                        'Harga satuan : ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          name: 'Rp ',
                          decimalDigits: 0,
                        ).format(d.harga),
                      ),
                    ]),
                    Expanded(
                      child: Row(children: <Widget>[
                        Text(
                          'Harga subtotal : ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            name: 'Rp ',
                            decimalDigits: 0,
                          ).format(d.subtotal),
                        ),
                      ]),
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
        children: <Widget>[
          Container(
            width: 110,
            child: Text(
              'Harga total:',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            totalHarga,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
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
        elevation: 1,
        title: Text(
          'CART LIST',
          style: TextStyle(
            fontSize: 24,
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
      backgroundColor: Colors.white,
      body: Container(
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
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

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  totalBar(),
                  button('NEXT'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
