import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_send_transaksi_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_v_nota_penjualan.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'akuntan_get_daftar_akun.dart';

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
            title: Text('Daftar Nota Penjualan'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
            },
          ),
          ListTile(
            title: Text('Input Penjurnalan'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AkuntanInputPenjurnalan()));
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
            title: Text("Halaman Utama"),
          ),
          drawer: widgetDrawer(),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    fetchDataAkuntanInputTransaksiPenjurnalanArray();
                  },
                  child: Text('From Postman'))
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
