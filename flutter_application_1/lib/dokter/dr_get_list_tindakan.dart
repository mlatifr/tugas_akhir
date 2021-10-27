library flutter_application_1.dr_get_list_tindakan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<DokterVListTIndakan> DVLTs = [];

class DokterVListTIndakan {
  var visitId, idTindakan, namaTIndakan, hargaTIndakan;
  DokterVListTIndakan({
    this.idTindakan,
    this.namaTIndakan,
    this.hargaTIndakan,
  });

  // untuk convert dari jSon
  factory DokterVListTIndakan.fromJson(Map<String, dynamic> json) {
    return new DokterVListTIndakan(
      idTindakan: json['idTindakan'],
      namaTIndakan: json['namaTIndakan'],
      hargaTIndakan: json['hargaTIndakan'],
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

// ignore: non_constant_identifier_names
DokterBacaDataVListTindakan() {
  Future<String> data = fetchDataDokterVListTindakan();
  data.then((value) {
    //Mengubah json menjadi Array
    // ignore: unused_local_variable
    Map json = jsonDecode(value);
    for (var i in json['data']) {
      print(i);
      DokterVListTIndakan dvlt = DokterVListTIndakan.fromJson(i);
      DVLTs.add(dvlt);
    }
  });
}
