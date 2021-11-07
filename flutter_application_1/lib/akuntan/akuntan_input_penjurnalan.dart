import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_get_daftar_akun.dart';
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

  List<String> selectedItemValue;
  Widget widgetDropDownButton() {
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
                  print('${valIdAkun}');
                });
              },
            ),
          ),
        ],
      ),
    );
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
                        fetchDataAkuntanVDftrAkun().then((value) {
                          AkntVDftrAkns.clear();
                          //Mengubah json menjadi Array
                          // ignore: unused_local_variable
                          Map json = jsonDecode(value);
                          for (var i in json['data']) {
                            AkuntanVDftrAkun dvlt =
                                AkuntanVDftrAkun.fromJson(i);
                            AkntVDftrAkns.add(dvlt);
                          }
                          setState(() {
                            widgetDropDownButton();
                          });
                        });
                      },
                      child: Text('Ok'))),
              widgetDropDownButton(),
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
