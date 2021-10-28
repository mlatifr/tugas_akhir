library flutter_application_1.dr_get_list_tindakan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<DokterVListTindakan> DVLTs = [];

class DokterVListTindakan {
  var visitId, idTindakan, namaTindakan, hargaTindakan;
  DokterVListTindakan({
    this.idTindakan,
    this.namaTindakan,
    this.hargaTindakan,
  });

  // untuk convert dari jSon
  factory DokterVListTindakan.fromJson(Map<String, dynamic> json) {
    return new DokterVListTindakan(
      idTindakan: json['id'],
      namaTindakan: json['nama'],
      hargaTindakan: json['harga'],
    );
  }
}

Future<String> fetchDataDokterVListTindakan() async {
  final response = await http.post(
    Uri.parse(APIurl + "dokter_v_list_tindakan.php"),
  );
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterInputTindakan(pVisitId,ptdkId,pmtSisi) async {
  final response = await http.post(
      Uri.parse(APIurl + "dokter_input_tindakan_array.php"),
      body: {"visit_id": "1", "tindakan_id": '1', "mt_sisi": "kiri"});
  if (response.statusCode == 200) {
    print('200: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
