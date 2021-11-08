import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_get_daftar_akun.dart';
import 'package:flutter_application_1/akuntan/akuntan_keranjang_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_main_page.dart';
import 'package:flutter_application_1/main.dart';

import 'akuntan_v_nota_penjualan.dart';

class AkuntanInputPenjurnalan extends StatefulWidget {
  const AkuntanInputPenjurnalan({Key key}) : super(key: key);

  @override
  _AkuntanInputPenjurnalanState createState() =>
      _AkuntanInputPenjurnalanState();
}

class _AkuntanInputPenjurnalanState extends State<AkuntanInputPenjurnalan> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n ' + username,
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.85),
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('./asset/image/clinic_text.jpg'),
              ),
            ),
          ),
          ListTile(
            title: Text('Halaman Utama'),
            onTap: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => AkuntanMainPage()));
            },
          ),
          ListTile(
            title: Text('Nota Penjualan'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // _timerForInter.cancel();
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  List<String> selectedItemTindakan;
  Widget widgetDropDownTindakan() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: DropdownButton(
              hint: Text("Pilih Akun"),
              value: valIdAkun,
              items: AkntVDftrAkns.map((value) {
                return DropdownMenuItem(
                  child: Text(value.namaAkun),
                  value: value.idAkun,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  valIdAkun = value;
                  print('$valIdAkun');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    fetchDataAkuntanVDftrAkun().then((value) {
      AkntVDftrAkns.clear();
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        AkuntanVDftrAkun dvlt = AkuntanVDftrAkun.fromJson(i);
        AkntVDftrAkns.add(dvlt);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Input Penjurnalan"),
          ),
          drawer: widgetDrawer(),
          body: Column(
            children: [
              widgetDropDownTindakan(),
              ElevatedButton(
                  onPressed: () {
                    // ListAkuntanKeranjangPenjurnalans.clear();
                    // AkuntanKeranjangPenjurnalan krjgPnjrnl;
                    // krjgPnjrnl = AkuntanKeranjangPenjurnalan(
                    //     penjurnalan_id: 'penjurnalan_id $valIdAkun',
                    //     daftar_akun_id: '$valIdAkun',
                    //     tgl_catat: 'tgl_catat $valIdAkun',
                    //     debet: 'debet $valIdAkun',
                    //     kredit: 'kredit $valIdAkun',
                    //     ket_transaksi: 'ket_transaksi $valIdAkun');
                    // ListAkuntanKeranjangPenjurnalans.add(krjgPnjrnl);

                    for (var i = 0; i < 10; i++) {
                      // print('print i $i');
                      fetchDataInputKeranjangPenjurnalan(
                              1, i + 1, i + 1, i + 1, i + 1, i + 1
                              // ListAkuntanKeranjangPenjurnalans[0].penjurnalan_id,
                              // ListAkuntanKeranjangPenjurnalans[0].daftar_akun_id,
                              // ListAkuntanKeranjangPenjurnalans[0].tgl_catat,
                              // ListAkuntanKeranjangPenjurnalans[0].debet,
                              // ListAkuntanKeranjangPenjurnalans[0].kredit,
                              // ListAkuntanKeranjangPenjurnalans[0].ket_transaksi,
                              )
                          .then((value) => print(value));
                      // print(
                      //     '${ListAkuntanKeranjangPenjurnalans[i].penjurnalan_id}');
                    }
                  },
                  child: Text('simpan')),
              ElevatedButton(
                  onPressed: () {
                    // LKrjgPenjurnalanToArray();
                    ListAkuntanKeranjangPenjurnalans.clear();
                  },
                  child: Text('Keranjang Print')),
            ],
          )),
    );
  }
}
