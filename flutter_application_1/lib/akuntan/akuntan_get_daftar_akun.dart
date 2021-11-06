library flutter_application_1.kasir_get_antrean;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanVDftrAkun> AkntVDftrAkns = [];
var valIdAkun, valueNamaAkun;

class AkuntanVDftrAkun {
  var idAkun, namaAkun;
  AkuntanVDftrAkun({
    this.idAkun,
    this.namaAkun,
  });

  // untuk convert dari jSon
  factory AkuntanVDftrAkun.fromJson(Map<String, dynamic> json) {
    return new AkuntanVDftrAkun(
      idAkun: json['id'],
      namaAkun: json['nama'],
    );
  }
}

Future<String> fetchDataAkuntanVDftrAkun() async {
  final response = await http.post(
    Uri.parse(APIurl + "akuntan_v_dftr_akun.php"),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
