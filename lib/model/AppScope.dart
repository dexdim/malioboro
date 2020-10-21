import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
//import '../Cart.dart';

class PromoList {
  dynamic id;
  String nama;
  String tglawal;
  String tglakhir;
  String jenis;
  String tenant;
  String logo;

  PromoList(
    this.id,
    this.nama,
    this.tglawal,
    this.tglakhir,
    this.jenis,
    this.tenant,
    this.logo,
  );
}

class TenantList {
  dynamic id;
  String nama;
  String lokasi;
  String kategori;
  String jam;
  String telp;
  String logo;
  String image;
  String deskripsi;

  TenantList(
    this.id,
    this.nama,
    this.lokasi,
    this.kategori,
    this.jam,
    this.telp,
    this.logo,
    this.image,
    this.deskripsi,
  );
}

class Data {
  int id;
  String nama;
  String deskripsi;
  int harga;
  String gambar;
  int shopid;
  int counter;
  int subtotal;

  Data({
    this.nama,
    this.deskripsi,
    this.harga,
    this.gambar,
  });
}

List data;

class AppModel extends Model {
  AppModel() {
    fetchPromo();
    fetchTenant();
  }
  //CartState cartState;
  //List<String> highlight = [];
  List<PromoList> promo = [];
  List<TenantList> tenant = [];
  List<Data> catalog = [];
  List<Data> cart = [];
  String cartMsg = '';
  String cartEmpty = "Hey it's still empty! Fill your cart.";
  bool success = false;
  Database _db;
  Directory tempDir;
  String tempPath;
  final LocalStorage storage = new LocalStorage('app_data');
  final String url =
      'http://www.malmalioboro.co.id/index.php/api/produk/get_list';
  final String promoUrl =
      'http://www.malmalioboro.co.id/index.php/api/event/get_list_promo_50';
  final String tenantUrl =
      'http://www.malmalioboro.co.id/index.php/api/tenant/get_list';

  //Item listing to Catalog()
  List<Data> get itemListing => catalog;

  //Cart listing to Cart()
  List<Data> get cartListing => cart;

  get finalPrint => printCart();

  Future<String> fetchPromo() async {
    Map body = {'jenis': 'Promo'};
    http.Response response = await http.post(
      Uri.encodeFull(promoUrl),
      body: body,
    );
    var parse = json.decode(response.body);
    parse?.forEach(
      (dynamic p) {
        final PromoList fetch = PromoList(
          p['id'],
          p['nama'],
          p['tglawal'],
          p['tglakhir'],
          p['jenis'],
          p['tenant'],
          p['logo'],
        );
        promo.add(fetch);
      },
    );
    return ('Success!');
  }

  Future<String> fetchTenant() async {
    http.Response response = await http.get(
      Uri.encodeFull(tenantUrl),
    );
    var parse = json.decode(response.body);
    parse?.forEach(
      (dynamic t) {
        final TenantList fetch = TenantList(
          t['id'],
          t['nama'],
          t['lokasi'],
          t['kategori'],
          t['jam'],
          t['telp'],
          t['logo'],
          t['image'],
          t['deskripsi'],
        );
        tenant.add(fetch);
      },
    );
    return 'Success!';
  }

  Future<String> fetchData(String id) async {
    Map body = {'idtenan': '$id'};
    http.Response response = await http.post(
      Uri.encodeFull(url),
      body: body,
    );
    var parse = json.decode(response.body);
    data = parse;
    createDB(id);
    return 'Success!';
  }

  //Create database cart.db
  createDB(String id) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'cart$id.db');
      print(path);
      //await storage.deleteItem('isFirst');
      //await this.deleteDB(id);

      var database = await openDatabase(
        path,
        version: 1,
        onOpen: (Database db) {
          this._db = db;
          print('OPEN DBV');
          this.createTable();
        },
        onCreate: (Database db, int version) async {
          this._db = db;
          print('DB Created');
        },
      );
    } catch (e) {
      print('ERRR >>>>');
      print(e);
    }
  }

  //Delete database cart.db
  deleteDB(String id) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cart$id.db');

    await deleteDatabase(path);
    if (storage.getItem('isFirst') != null) {
      await storage.deleteItem('isFirst');
    }
  }

  //Buat tabel item_list & cart_list jika belum ada tabel
  createTable() async {
    try {
      String qry = 'CREATE TABLE IF NOT EXISTS item_list ( '
          'id INTEGER PRIMARY KEY,'
          'nama TEXT,'
          'deskripsi TEXT,'
          'harga INT,'
          'gambar TEXT,'
          'datetime DATETIME)';
      await this._db.execute(qry);
      qry = 'CREATE TABLE IF NOT EXISTS cart_list ( '
          'id INTEGER PRIMARY KEY,'
          'shopid INTEGER,'
          'nama TEXT,'
          'deskripsi TEXT,'
          'harga INT,'
          'gambar TEXT,'
          'counter INT,'
          'subtotal INT,'
          'datetime DATETIME)';

      await this._db.execute(qry);

      var _flag = storage.getItem('isFirst');
      print('FLAG IS FIRST $_flag');
      if (_flag == 'true') {
        this.fetchLocalData();
        this.fetchCartList();
      } else {
        this.insertInLocal();
      }
    } catch (e) {
      print('ERRR ^^^');
      print(e);
    }
  }

  //Isi data item dari API ke dalam tabel item_list & list array _data
  insertInLocal() async {
    try {
      await this._db.transaction(
        (tx) async {
          for (var i = 0; i < data.length; i++) {
            print('Called insert $i');
            Data d = new Data();
            d.id = i + 1;
            d.nama = data[i]['nama'];
            d.deskripsi = data[i]['deskripsi'];
            d.gambar = data[i]['gambar'];
            d.harga = int.parse(data[i]['harga']);
            try {
              var qry =
                  "INSERT INTO item_list(nama, deskripsi, harga, gambar) VALUES('${d.nama}', '${d.deskripsi}', ${d.harga}, '${d.gambar}')";
              var _res = await tx.rawInsert(qry);
            } catch (e) {
              print('ERRR >>>');
              print(e);
            }
            catalog.add(d);
            notifyListeners();
          }
          storage.setItem('isFirst', 'true');
        },
      );
    } catch (e) {
      print('ERRR ## > ');
      print(e);
    }
  }

  //Ambil record item dari tabel item_list
  fetchLocalData() async {
    try {
      List<Map> list = await this._db.rawQuery('SELECT * FROM item_list');
      list.map(
        (dd) {
          Data d = new Data();
          d.id = dd['id'];
          d.nama = dd['nama'];
          d.deskripsi = dd['deskripsi'];
          d.gambar = dd['gambar'];
          d.harga = dd['harga'];
          catalog.add(d);
        },
      ).toList();
      notifyListeners();
    } catch (e) {
      print('ERRR %%%');
      print(e);
    }
  }

  //Isi tambah list array _cart dari list array _data
  void addCart(Data dd) {
    print(dd);
    print(cart);
    int _index = cart.indexWhere((d) => d.shopid == dd.id);
    if (_index > -1) {
      success = false;
      cartMsg = '${dd.nama.toUpperCase()} already in your cart.';
    } else {
      this.insertInCart(dd);
      success = true;
      cartMsg = '${dd.nama.toUpperCase()} successfully added to your cart.';
    }
  }

  //Isi tabel cart_list dari list array _data
  insertInCart(Data d) async {
    await this._db.transaction(
      (tx) async {
        try {
          var qry =
              "INSERT INTO cart_list(shopid, nama, deskripsi, harga, gambar, counter, subtotal) VALUES (${d.id},'${d.nama}', '${d.deskripsi}', ${d.harga},'${d.gambar}', ${d.counter}, ${d.subtotal})";
          var _res = await tx.execute(qry);
          this.fetchCartList();
        } catch (e) {
          print('ERRR @@ @@');
          print(e);
        }
      },
    );
  }

  //Ambil record item dari tabel cart_list
  fetchCartList() async {
    try {
      cart = [];
      List<Map> list = await this._db.rawQuery('SELECT * FROM cart_list');
      print('Cart len ${list.length.toString()}');
      list.map(
        (dd) {
          Data d = new Data();
          d.id = dd['id'];
          d.nama = dd['nama'];
          d.deskripsi = dd['deskripsi'];
          d.harga = dd['harga'];
          d.gambar = dd['gambar'];
          d.counter = dd['counter'];
          d.subtotal = dd['subtotal'];
          d.shopid = dd['shopid'];
          cart.add(d);
        },
      ).toList();
      notifyListeners();
    } catch (e) {
      print('ERRR @##@');
      print(e);
    }
  }

  //Tambah item (next implementation)
  void addItem(Data dd) {
    Data d = new Data();
    d.id = catalog.length + 1;
    d.nama = 'nama';
    d.deskripsi = 'deskripsi';
    d.gambar = 'http://malmalioboro.co.id';
    d.harga = 1500;
    d.counter = 1;
    catalog.add(d);
    notifyListeners();
  }

  //Delete record dari tabel cart_list jika ada item yang dihapus
  removeCartDB(Data d) async {
    try {
      var qry = 'DELETE FROM cart_list where id = ${d.id}';
      this._db.rawDelete(qry).then(
        (data) {
          print(data);
          int _index = cart.indexWhere((dd) => dd.id == d.id);
          cart.removeAt(_index);
          notifyListeners();
        },
      ).catchError(
        (e) {
          print(e);
        },
      );
    } catch (e) {
      print('ERR rm cart$e');
    }
  }

  // Remove Cart
  void removeCart(Data dd) {
    this.removeCartDB(dd);
  }

  printCart() {}
}
