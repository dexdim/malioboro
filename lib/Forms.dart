import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:email_validator/email_validator.dart';
import 'Cart.dart';
import 'model/AppScope.dart';

class Forms extends StatefulWidget {
  static final String route = 'Form-route';

  @override
  FormsState createState() => FormsState();
}

class FormsState extends State<Forms> {
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final nomorhpController = TextEditingController();
  final emailController = TextEditingController();
  String namapemesan;
  String nomorhp;
  bool validate = false;

  @override
  void dispose() {
    namaController.dispose();
    nomorhpController.dispose();
    super.dispose();
  }

  Widget button(String title) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
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
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              List<TenantList> tenantData =
                  ScopedModel.of<AppModel>(context).tenant;
              if (formKey.currentState.validate()) {
                var finalPrint = '';
                printItem(Data d) {
                  finalPrint +=
                      '\nNama barang : ${d.nama}\nHarga satuan : Rp ${d.harga}\nKode barcode : ${d.deskripsi}\nJumlah : ${d.counter} , Harga subtotal : Rp ${d.subtotal}\n';
                }

                finalPrint += 'Halo Supermarket Malioboro Mall\n';
                finalPrint += 'Berikut adalah daftar belanja dari,\n';
                finalPrint += 'Nama pemesan: ${namaController.text}\n';
                finalPrint += 'Nomor handphone: ${nomorhpController.text}';
                finalPrint += '\n=================\n\n';
                model.cartListing.map((d) => printItem(d)).toString();
                finalPrint +=
                    '\n\n=================\nHarga total : ${CartState.totalHarga}';
                finalPrint +=
                    '\n\nMohon untuk cek ketersediaan stocknya. Terima kasih.';

                FlutterOpenWhatsapp.sendSingleMessage(
                    '6282138020366', '${finalPrint.toString()}');
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Color(0xfffee18e),
          )
        ],
      );
    });
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Text(
        'Untuk proses selanjutnya silakan anda melengkapi form pemesanan dengan lengkap',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  inputDecoration(String title) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      labelText: title,
      labelStyle: TextStyle(color: Colors.grey[850], fontSize: 18),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.brown,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  Widget formField(String title, controller) {
    if (title == 'Email') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller,
                  onSaved: (value) => title = value,
                  style: TextStyle(color: Colors.grey[850], fontSize: 16),
                  decoration: inputDecoration(title),
                  validator: (value) => !EmailValidator.validate(value, true)
                      ? 'Email tidak valid / masih kosong!'
                      : null,
                ),
              ),
            ]),
      );
    } else if (title == 'Nomor Handphone') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  onSaved: (value) => title = value,
                  style: TextStyle(color: Colors.grey[850], fontSize: 16),
                  decoration: inputDecoration(title),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Kolom ${title.toLowerCase()} masih kosong!';
                    }
                    return null;
                  },
                ),
              ),
            ]),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width / 1.3,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: controller,
                  onSaved: (value) => title = value,
                  style: TextStyle(color: Colors.grey[850], fontSize: 16),
                  decoration: inputDecoration(title),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Kolom ${title.toLowerCase()} masih kosong!';
                    }
                    return null;
                  },
                ),
              ),
            ]),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FORM ORDER',
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
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: formKey,
              child: Column(children: <Widget>[
                SizedBox(height: 50),
                header(),
                SizedBox(height: 50),
                formField('Nama Lengkap', namaController),
                formField('Alamat', alamatController),
                formField('Email', emailController),
                formField('Nomor Handphone', nomorhpController),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xfffee18e),
        child: Container(
          height: 70,
          child: button('ORDER VIA WHATSAPP'),
        ),
      ),
    );
  }
}
