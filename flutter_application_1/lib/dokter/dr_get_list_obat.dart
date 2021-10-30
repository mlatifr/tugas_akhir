library flutter_application_1.dr_get_list_tindakan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<DokterVListObat> DVLOs = [];

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
    print('200: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterInputResepObat(
    pObtId, pDosis, pJumlah, pVisitId) async {
  print('final: $pObtId | $pDosis | $pJumlah | $pVisitId');
  final response = await http
      .post(Uri.parse(APIurl + "dokter_input_resep_has_obat.php"), body: {
    "obat_id": pObtId.toString(),
    "dosis": pDosis.toString(),
    "jumlah": pJumlah.toString(),
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    print('200: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
