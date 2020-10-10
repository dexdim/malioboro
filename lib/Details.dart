import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'model/CatalogScope.dart';

class Details extends StatefulWidget {
  static final String route = 'Details-route';
  final Data detail;
  Details({this.detail});

  // TODO: implement createState
  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  int counter = 1;
  int subtotal = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //int active = 0;

  Widget button(String title) {
    return ScopedModelDescendant<CatalogModel>(
        builder: (context, child, model) {
      return RaisedButton(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.orange[200],
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
            model.addCart(widget.detail);
            Timer(Duration(milliseconds: 500), () {
              showDetailSnack(model.cartMsg, model.success);
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.orange[100]);
    });
  }

  Widget counterBar() {
    widget.detail.counter = 1;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SizedBox(height: 100),
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
            border: Border.all(color: Colors.orange[200]),
          ),
          child: Icon(
            Icons.remove,
            size: 20,
          ),
        ),
      ),
      SizedBox(width: 30),
      Text(
        "$counter",
        style: TextStyle(fontSize: 25),
      ),
      SizedBox(width: 30),
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
            border: Border.all(color: Colors.orange[200]),
          ),
          child: Icon(
            Icons.add,
            size: 20,
          ),
        ),
      ),
    ]);
  }

  showDetailSnack(String msg, bool flag) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: (flag) ? Colors.green : Colors.red[500],
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget subtotalBar() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        children: <Widget>[
          Container(
            width: 140.0,
            child: Text(
              'Harga subtotal:',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          ScopedModelDescendant<CatalogModel>(builder: (context, child, model) {
            widget.detail.counter = counter;
            widget.detail.subtotal = counter * widget.detail.harga;
            return Text(
              NumberFormat.currency(
                locale: 'id',
                name: 'Rp ',
                decimalDigits: 0,
              ).format(widget.detail.subtotal),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String hargaSatuan = NumberFormat.currency(
      locale: 'id',
      name: 'Rp ',
      decimalDigits: 0,
    ).format(widget.detail.harga);
    // TODO: implement build
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Detail Item'),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
            ),
          ),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 425,
                    padding: EdgeInsets.only(top: 25.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 300.0,
                          child: Image(
                            image: NetworkImage(
                                'http://www.malmalioboro.co.id/${widget.detail.gambar}'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        counterBar()
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                height: 1.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.detail.nama,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Harga satuan : $hargaSatuan',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          color: Colors.orangeAccent),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kode barcode : ${widget.detail.deskripsi}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            //margin: EdgeInsets.only(top: 10),
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                subtotalBar(),
                button('BELI'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
