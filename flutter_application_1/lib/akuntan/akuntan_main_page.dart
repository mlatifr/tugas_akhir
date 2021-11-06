import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

  String _valGender;
  String _valFriends;
  List _listGender = ["Male", "Female"];
  List _myFriends = [
    "Clara",
    "John",
    "Rizal",
    "Steve",
    "Laurel",
    "Bernard",
    "Miechel"
  ];
  List<String> selectedItemValue;
  Widget widgetDropDownButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton(
            hint: Text("Pilih Akun"),
            value: valueNamaAkun,
            items: AkntVDftrAkns.map((value) {
              return DropdownMenuItem(
                child: Text(value.namaAkun),
                value: value.idAkun,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                valueNamaAkun = value;
                valIdAkun = value;
                print('id akun yg dipilih : ${valIdAkun}');
              });
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
      setState(() {
        widgetDropDownButton();
      });
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
