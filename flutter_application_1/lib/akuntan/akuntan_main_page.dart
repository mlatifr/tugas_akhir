import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_v_nota_penjualan.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class AkuntanMainPage extends StatefulWidget {
  const AkuntanMainPage({Key key}) : super(key: key);

  @override
  _AkuntanMainPageState createState() => _AkuntanMainPageState();
}

class _AkuntanMainPageState extends State<AkuntanMainPage> {
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
            title: Text('Input Daftar Akun'),
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

  var bodyPost = {
    'transaksi_array': {
      'transaksi_1': {
        'penjurnalan_id': '1',
        'daftar_akun_id': '4',
        'tgl_catat': '2021-10-01',
        'debet': '1000000',
        'kredit': '',
        'ket_transaksi': 'pendapatan jasa medis'
      },
      'transaksi_2': {
        'penjurnalan_id': '1',
        'daftar_akun_id': '1',
        'tgl_catat': '2021-10-01',
        'debet': '',
        'kredit': '1000000',
        'ket_transaksi': 'pendapatan jasa medis'
      },
    }
  };
  Future<String> fetchDataAkuntanInputTransaksiPenjurnalan() async {
    final response =
        await http.post(Uri.parse(APIurl + "akuntan_inpt_penjurnalan_akun.php"),
            // body: {'bodyPost': '1'});
            body: {
          'penjurnalan_id': '1',
          'daftar_akun_id': '4',
          'tgl_catat': '2021-10-01',
          'debet': '1000000',
          'kredit': '',
          'ket_transaksi': 'pendapatan jasa medis'
        });
    // body: jsonEncode({transaksi_array}));
    if (response.statusCode == 200) {
      print('fetchDataAkuntanInputTransaksiPenjurnalan: ${response.body}');
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("List Nota"),
          ),
          drawer: widgetDrawer(),
          body: Column(
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        fetchDataAkuntanInputTransaksiPenjurnalan();
                        // var jE = jsonEncode(transaksi_array);
                        // var jD = jsonDecode(jE);
                        // print(transaksi_array.toString());
                      },
                      child: Text('Ok')))
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
