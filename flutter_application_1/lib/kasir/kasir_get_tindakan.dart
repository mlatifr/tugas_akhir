library flutter_application_1.kasir_get_tindakan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<KasirVKeranjangTindakan> DVKTs = [];

class KasirVKeranjangTindakan {
  var visitHasTdknId, tdknId, vstId, mtSisi;
  KasirVKeranjangTindakan(
      {this.visitHasTdknId, this.tdknId, this.vstId, this.mtSisi});

  // untuk convert dari jSon
  factory KasirVKeranjangTindakan.fromJson(Map<String, dynamic> json) {
    return new KasirVKeranjangTindakan(
      visitHasTdknId: json['id'],
      tdknId: json['tindakan_id'],
      vstId: json['visit_id'],
      mtSisi: json['mt_sisi'],
    );
  }
}

Future<String> fetchDataDokterVKeranjangTindakan(pVisitId) async {
  print('final: $pVisitId');
  final response = await http.post(Uri.parse(APIurl + "kasir_v_tindakan.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    print('keranjang tindakan: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
