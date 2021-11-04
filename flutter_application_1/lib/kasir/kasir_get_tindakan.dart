library flutter_application_1.kasir_get_tindakan;

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

Future<String> fetchDataKasirVKeranjangTindakan(pVisitId) async {
  // print('fetchDataDokterVKeranjangTindakan : $pVisitId');
  final response = await http.post(Uri.parse(APIurl + "kasir_v_tindakan.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    // print('fetchDataDokterVKeranjangTindakan: ${response.body}');
    return response.body;
  } else {
    // print(' fetchDataDokterVKeranjangTindakan else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
