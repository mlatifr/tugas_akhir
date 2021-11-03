library flutter_application_1.kasir_get_resep;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<KasirVKeranjangResep> KVKRs = [];

class KasirVKeranjangResep {
  var resep_id,
      user_id_apoteker,
      tgl_resep,
      obat_id,
      jumlah,
      dosis,
      namaObat,
      stok,
      hargaJual;
  KasirVKeranjangResep(
      {this.resep_id,
      this.user_id_apoteker,
      this.tgl_resep,
      this.obat_id,
      this.jumlah,
      this.dosis,
      this.namaObat,
      this.stok,
      this.hargaJual});

  // untuk convert dari jSon
  factory KasirVKeranjangResep.fromJson(Map<String, dynamic> json) {
    return new KasirVKeranjangResep(
      resep_id: json['resep_id'],
      user_id_apoteker: json['user_id_apoteker'],
      tgl_resep: json['tgl_resep'],
      obat_id: json['obat_id'],
      jumlah: json['jumlah'],
      dosis: json['dosis'],
      namaObat: json['nama'],
      stok: json['stok'],
      hargaJual: json['harga_jual'],
    );
  }
}

Future<String> fetchDataDokterVKeranjangResep(pVisitId) async {
  print('final: $pVisitId');
  final response = await http.post(Uri.parse(APIurl + "kasir_v_resep.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    print('keranjang kasir_v_resep: ${response.body}');
    return response.body;
  } else {
    print('else kasir_v_resep: ${response.body}');
    throw Exception('Failed to read API');
  }
}
