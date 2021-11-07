library flutter_application_1.akuntan_keranjang_penjurnalan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanKeranjangPenjurnalan> ListAkuntanKeranjangPenjurnalans = [];

class AkuntanKeranjangPenjurnalan {
  var penjurnalan_id, daftar_akun_id, tgl_catat, debet, kredit, ket_transaksi;
  AkuntanKeranjangPenjurnalan({
    this.penjurnalan_id,
    this.daftar_akun_id,
    this.tgl_catat,
    this.debet,
    this.kredit,
    this.ket_transaksi,
  });
}
