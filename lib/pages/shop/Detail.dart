import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:intl/intl.dart';
import 'package:malioboromall/model/AppScope.dart';

class Detail extends StatefulWidget {
  static final String route = 'Detail-route';
  final Data detail;
  Detail({this.detail});

  // TODO: implement createState
  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  int counter = 1;
  int subtotal = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //int active = 0;

  Widget button(String title) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
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
          horizontal: 30,
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
          model.addCart(widget.detail, widget.detail.idtenan);
          Timer(Duration(milliseconds: 500), () {
            showDetailSnack(model.cartMsg, model.success);
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Color(0xfffee18e),
      );
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
            border: Border.all(
              color: Colors.brown,
            ),
          ),
          child: Icon(
            Icons.remove,
            size: 16,
          ),
        ),
      ),
      SizedBox(width: 30),
      Text(
        "$counter",
        style: TextStyle(fontSize: 20),
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
            border: Border.all(
              color: Colors.brown,
            ),
          ),
          child: Icon(
            Icons.add,
            size: 16,
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
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: (flag) ? Colors.green : Colors.red[500],
        duration: Duration(seconds: 5),
      ),
    );
  }

  Widget subtotalBar() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 140.0,
            child: Text(
              'Subtotal price :',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.brown,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ScopedModelDescendant<AppModel>(builder: (context, child, model) {
            widget.detail.counter = counter;
            widget.detail.subtotal = counter * widget.detail.harga;
            return Text(
              '${NumberFormat.currency(
                locale: 'id',
                name: 'Rp ',
                decimalDigits: 0,
              ).format(widget.detail.subtotal)},-',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Item Detail',
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
        elevation: 0,
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
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        width: 250,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image(
                              image: NetworkImage(
                                  'http://www.malmalioboro.co.id/${widget.detail.gambar}'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      counterBar()
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                  height: 1.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.detail.nama,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Price : $hargaSatuan,-',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.brown),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Description : ${widget.detail.deskripsi}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '*The price may be changed without notice.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xfffee18e),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 90.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              subtotalBar(),
              SizedBox(
                height: 10,
              ),
              button('ADD TO CART'),
            ],
          ),
        ),
      ),
    );
  }
}
