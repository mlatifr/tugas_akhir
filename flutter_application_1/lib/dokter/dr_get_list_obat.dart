library flutter_application_1.dr_get_list_tindakan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<DokterVListObat> DVLOs = [];
List<DokterVKeranjangObat> DVLKOs = [];

class DokterVKeranjangObat {
  var obatNama, obatJumlah, obatDosis;
  DokterVKeranjangObat({
    this.obatNama,
    this.obatJumlah,
    this.obatDosis,
  });

  // untuk convert dari jSon
  factory DokterVKeranjangObat.fromJson(Map<String, dynamic> json) {
    return new DokterVKeranjangObat(
      obatNama: json['nama'],
      obatJumlah: json['jumlah'],
      obatDosis: json['dosis'],
    );
  }
}

class DokterVListObat {
  var obatId, obatNama, obatStok;
  DokterVListObat({
    this.obatId,
    this.obatNama,
    this.obatStok,
  });

  // untuk convert dari jSon
  factory DokterVListObat.fromJson(Map<String, dynamic> json) {
    return new DokterVListObat(
      obatId: json['id'],
      obatNama: json['nama'],
      obatStok: json['stok'],
    );
  }
}

Future<String> fetchDataDokterVListObat(pNamaObat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.post(Uri.parse(APIurl + "dokter_v_list_obat.php"),
      body: {'nama_obat': pNamaObat.toString()});
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterInputResepObat(
    pObtId, pDosis, pJumlah, pVisitId) async {
  // print('final: $pObtId | $pDosis | $pJumlah | $pVisitId');
  final response = await http
      .post(Uri.parse(APIurl + "dokter_input_resep_has_obat.php"), body: {
    "obat_id": pObtId.toString(),
    "dosis": pDosis.toString(),
    "jumlah": pJumlah.toString(),
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterKeranjangObat(pVisitId) async {
  // print('final:$pVisitId');
  final response = await http
      .post(Uri.parse(APIurl + "dokter_v_keranjang_resep_obat.php"), body: {
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
