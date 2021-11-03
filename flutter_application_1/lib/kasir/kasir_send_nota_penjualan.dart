library flutter_application_1.kasir_send_nota_penjualan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<KasirVKeranjangTindakan> KVKTs = [];

class KasirVKeranjangTindakan {
  var visitHasTdknId, nama, harga, mtSisi;
  KasirVKeranjangTindakan(
      {this.visitHasTdknId, this.nama, this.harga, this.mtSisi});

  // untuk convert dari jSon
  factory KasirVKeranjangTindakan.fromJson(Map<String, dynamic> json) {
    return new KasirVKeranjangTindakan(
      visitHasTdknId: json['visit_has_tindakan_id'],
      nama: json['nama'],
      harga: json['harga'],
      mtSisi: json['mt_sisi'],
    );
  }
}

Future<String> fetchDataKasirInputNotaJual(
    pUser_id,
    pVisit_id,
    pResep_apoteker_id,
    pTgl_transaksi,
    pJasa_medis,
    pBiaya_admin,
    pTotal_harga) async {
  final response =
      await http.post(Uri.parse(APIurl + "kasir_input_nota_jual.php"), body: {
    "user_id": pUser_id.toString(),
    "visit_id": pVisit_id.toString(),
    "resep_apoteker_id": pResep_apoteker_id.toString(),
    "tgl_transaksi": pTgl_transaksi.toString().substring(0, 10),
    "jasa_medis": pJasa_medis.toString(),
    "biaya_admin": pBiaya_admin.toString(),
    "total_harga": pTotal_harga.toString(),
  });
  if (response.statusCode == 200) {
    print('keranjang tindakan: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
