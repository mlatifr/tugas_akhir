library flutter_application_1.akuntan_send_transaksi_penjurnalan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDataAkuntanInputTransaksiPenjurnalan(pPenjurnalan_id,
    pDaftar_akun_id, pTgl_catat, pDebet, pKredit, pKet_transaksi) async {
  final response =
      await http.post(Uri.parse(APIurl + "akuntan_inpt_penjurnalan_akun.php"),
          // body: {'bodyPost': '1'});
          body: {
        'penjurnalan_id': pPenjurnalan_id,
        'daftar_akun_id': pDaftar_akun_id,
        'tgl_catat': pTgl_catat,
        'debet': pDebet,
        'kredit': pKredit,
        'ket_transaksi': pKet_transaksi,
      });
  // body: jsonEncode({transaksi_array}));
  if (response.statusCode == 200) {
    print('fetchDataAkuntanInputTransaksiPenjurnalan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
