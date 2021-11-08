library flutter_application_1.akuntan_keranjang_penjurnalan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanKeranjangPenjurnalan> KeranjangTransaksiPenjurnalans = [];

class AkuntanKeranjangPenjurnalan {
  var penjurnalan_id,
      daftar_akun_id,
      daftar_akun_nama,
      tgl_catat,
      debet,
      kredit,
      ket_transaksi;
  AkuntanKeranjangPenjurnalan({
    this.penjurnalan_id,
    this.daftar_akun_id,
    this.daftar_akun_nama,
    this.tgl_catat,
    this.debet,
    this.kredit,
    this.ket_transaksi,
  });
}

// var transaksi_array = [];
// LKrjgPenjurnalanToArray() {
//   transaksi_array.clear();
//   for (var item in ListAkuntanKeranjangPenjurnalans) {
//     transaksi_array.add('penjurnalan_id[$item]: ${item.penjurnalan_id},'
//         'daftar_akun_id[$item]: ${item.daftar_akun_id},'
//         'tgl_catat[$item]: ${item.tgl_catat},'
//         'debet[$item]: ${item.debet},'
//         'kredit[$item]: ${item.kredit},'
//         'ket_transaksi[$item]: ${item.ket_transaksi},');
//   }
//   print(transaksi_array.toString());
// }

Future<String> fetchDataInputKeranjangPenjurnalan(
  p_penjurnalan_id,
  p_daftar_akun_id,
  p_tgl_catat,
  p_debet,
  p_kredit,
  p_ket_transaksi,
) async {
  final response = await http
      .post(Uri.parse(APIurl + "akuntan_inpt_penjurnalan_akun.php"), body: {
    'penjurnalan_id': p_penjurnalan_id.toString(),
    'daftar_akun_id': p_daftar_akun_id.toString(),
    'tgl_catat': p_tgl_catat.toString(),
    'debet': p_debet.toString(),
    'kredit': p_kredit.toString(),
    'ket_transaksi': p_ket_transaksi.toString(),
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
