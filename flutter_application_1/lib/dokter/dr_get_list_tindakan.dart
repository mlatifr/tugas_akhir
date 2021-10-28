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

// ignore: non_constant_identifier_names
DokterBacaDataVListTindakan() {
  DVLTs.clear();
  Future<String> data = fetchDataDokterVListTindakan();
  data.then((value) {
    //Mengubah json menjadi Array
    // ignore: unused_local_variable
    Map json = jsonDecode(value);
    for (var i in json['data']) {
      print('DokterBacaDataVListTindakan: ${i}');
      DokterVListTindakan dvlt = DokterVListTindakan.fromJson(i);
      DVLTs.add(dvlt);
    }
  });
}