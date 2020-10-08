import 'dart:async';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

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

class AppModel extends Model {
  List<String> highlight = [];
  List<PromoList> promo = [];
  List<TenantList> tenant = [];

  final String promoUrl =
      'http://www.malmalioboro.co.id/index.php/api/event/get_list_promo_20';
  final String tenantUrl =
      'http://www.malmalioboro.co.id/index.php/api/tenant/get_list';

  Future<String> fetchPromo() async {
    Map body = {'jenis': 'Promo'};
    http.Response response = await http.post(
      Uri.encodeFull(promoUrl),
      body: body,
    );
    var parse = json.decode(response.body);
    parse?.forEach((dynamic p) {
      final PromoList fetchPromo = PromoList(
        p['id'],
        p['nama'],
        p['tglawal'],
        p['tglakhir'],
        p['jenis'],
        p['tenant'],
        p['logo'],
      );
      promo.add(fetchPromo);
    });
    return ('Success!');
  }

  Future<String> fetchTenant() async {
    http.Response response = await http.get(
      Uri.encodeFull(tenantUrl),
    );
    var parse = json.decode(response.body);
    parse?.forEach((dynamic t) {
      final TenantList fetchTenant = TenantList(
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
      tenant.add(fetchTenant);
    });
    return 'Success!';
  }

  AppModel() {
    fetchPromo();
    fetchTenant();
  }
}
