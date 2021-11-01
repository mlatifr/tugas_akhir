library flutter_application_1.apt_get_resep_pasien_detail;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<ApotekerrVListObat> AVLOs = [];
List<ApotekerVKeranjangObat> AVKRDs = [];

class ApotekerVKeranjangObat {
  var resep_dokter_id, obat_id, nama, dosis, jumlah;
  ApotekerVKeranjangObat({
    this.resep_dokter_id,
    this.obat_id,
    this.nama,
    this.dosis,
    this.jumlah,
  });

  // untuk convert dari jSon
  factory ApotekerVKeranjangObat.fromJson(Map<String, dynamic> json) {
    return new ApotekerVKeranjangObat(
      resep_dokter_id: json['resep_dokter_id'],
      obat_id: json['obat_id'],
      nama: json['nama'],
      dosis: json['dosis'],
      jumlah: json['dosis'],
    );
  }
}

class ApotekerrVListObat {
  var obatId, obatNama, obatStok;
  ApotekerrVListObat({
    this.obatId,
    this.obatNama,
    this.obatStok,
  });

  // untuk convert dari jSon
  factory ApotekerrVListObat.fromJson(Map<String, dynamic> json) {
    return new ApotekerrVListObat(
      obatId: json['id'],
      obatNama: json['nama'],
      obatStok: json['stok'],
    );
  }
}

Future<String> fetchDataApotekerInputRspVst(
    pVisit_id, pUser_id_apoteker, pTgl_penulisan_resep) async {
  // print(
  //     'fetchDataApotekerInputRspVst: $pVisit_id | $pUser_id_apoteker | $pTgl_penulisan_resep');
  final response = await http
      .post(Uri.parse(APIurl + "apoteker_input_resep_visit.php"), body: {
    'visit_id': pVisit_id.toString(),
    'user_id_apoteker': pUser_id_apoteker.toString(),
    'tgl_penulisan_resep': pTgl_penulisan_resep.toString()
  });
  if (response.statusCode == 200) {
    print('fetchDataApotekerInputRspVst: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerVListObat(pNamaObat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.post(
      Uri.parse(APIurl + "apoteker_v_list_obat.php"),
      body: {'nama_obat': pNamaObat.toString()});
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerInputResepObat(
    pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) async {
  // print('final: $pObtId | $pDosis | $pJumlah | $pVisitId');
  final response = await http
      .post(Uri.parse(APIurl + "apoteker_input_resep_has_obat.php"), body: {
    "resep_apoteker_id": pRspAptkrId.toString(),
    "obat_id": pObtId.toString(),
    "dosis": pDosis.toString(),
    "jumlah": pJumlah.toString(),
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataApotekerInputResepObat: ${response.body}');
    return response.body;
  } else {
    print('else fetchDataApotekerInputResepObat: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerKeranjangObat(pVisitId) async {
  // print('final:$pVisitId');
  final response =
      await http.post(Uri.parse(APIurl + "apoteker_v_rsp_dr.php"), body: {
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
