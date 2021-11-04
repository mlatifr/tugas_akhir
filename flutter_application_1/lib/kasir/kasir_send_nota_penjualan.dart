library flutter_application_1.kasir_send_nota_penjualan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class KasirInputNotaJual {
  var visitHasTdknId, nama, harga, mtSisi;
  KasirInputNotaJual({this.visitHasTdknId, this.nama, this.harga, this.mtSisi});

  // untuk convert dari jSon
  factory KasirInputNotaJual.fromJson(Map<String, dynamic> json) {
    return new KasirInputNotaJual(
      visitHasTdknId: json['visit_has_tindakan_id'],
      nama: json['nama'],
      harga: json['harga'],
      mtSisi: json['mt_sisi'],
    );
  }
}

Future<String> fetchDataKasirInputNotaJual(pUser_id, pVisit_id, pTgl_transaksi,
    pJasa_medis, pBiaya_admin, pTotal_harga) async {
  final response =
      await http.post(Uri.parse(APIurl + "kasir_input_nota_jual.php"), body: {
    "user_id": pUser_id.toString(),
    "visit_id": pVisit_id.toString(),
    "tgl_transaksi": pTgl_transaksi.toString().substring(0, 10),
    "jasa_medis": pJasa_medis.toString(),
    "biaya_admin": pBiaya_admin.toString(),
    "total_harga": pTotal_harga.toString(),
  });
  if (response.statusCode == 200) {
    print('kasir_input_nota_jual tindakan:  \n'
        '$pUser_id \n'
        '$pVisit_id \n'
        '$pTgl_transaksi \n'
        '$pJasa_medis \n'
        '$pBiaya_admin \n'
        '$pTotal_harga \n'
        '${response.body}');
    return response.body;
  } else {
    print('kasir_input_nota_jual else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
