library flutter_application_1.akuntan_fetch_penjualanObat;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanVPenjualanObat> ListPenjualanObat = [];

class AkuntanVPenjualanObat {
  var tgl_resep, resep_id, obat_id, nama, jumlah, harga, total_harga;
  AkuntanVPenjualanObat({
    this.tgl_resep,
    this.resep_id,
    this.obat_id,
    this.nama,
    this.jumlah,
    this.harga,
    this.total_harga,
  });
  // untuk convert dari jSon
  factory AkuntanVPenjualanObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanObat(
        tgl_resep: json['tgl_resep'],
        resep_id: json['resep_id'],
        obat_id: json['obat_id'],
        nama: json['nama'],
        jumlah: json['jumlah'],
        harga: json['harga'],
        total_harga: json['total_harga']);
  }
}

Future<String> fetchDataVPenjualanObat(p_tgl_catat) async {
  final response =
      await http.post(Uri.parse(APIurl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_resep_non_visit': p_tgl_catat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
