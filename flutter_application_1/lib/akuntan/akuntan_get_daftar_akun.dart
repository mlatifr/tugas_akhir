library flutter_application_1.kasir_get_antrean;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanVDftrAkun> AkntVDftrAkns = [];

class AkuntanVDftrAkun {
  var visitId,
      vhuId,
      pasienId,
      tglVisit,
      userName,
      nomorAntrean,
      statusAntrean,
      keluhan;
  AkuntanVDftrAkun(
      {this.visitId,
      this.vhuId,
      this.pasienId,
      this.tglVisit,
      this.userName,
      this.nomorAntrean,
      this.statusAntrean,
      this.keluhan});

  // untuk convert dari jSon
  factory AkuntanVDftrAkun.fromJson(Map<String, dynamic> json) {
    return new AkuntanVDftrAkun(
      visitId: json['visit_id'],
      vhuId: json['vhu_id'],
      pasienId: json['pasien_id'],
      tglVisit: json['tgl_visit'],
      userName: json['username'],
      nomorAntrean: json['nomor_antrean'],
      statusAntrean: json['status_antrean'],
      keluhan: json['keluhan'],
    );
  }
}

Future<String> fetchDataAkuntanVDftrAkun(pDate) async {
  final response =
      await http.post(Uri.parse(APIurl + "dokter_v_antrean.php"), body: {
    'tgl_visit': pDate.toString().substring(0, 10),
    // 'tgl_visit': '2021-10-21',
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
