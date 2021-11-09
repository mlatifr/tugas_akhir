import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualanObat.dart';
import 'package:flutter_application_1/akuntan/akuntan_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_main_page.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AkuntanVNotaPjln extends StatefulWidget {
  const AkuntanVNotaPjln({Key key}) : super(key: key);

  @override
  _AkuntanVNotaPjlnState createState() => _AkuntanVNotaPjlnState();
}

class _AkuntanVNotaPjlnState extends State<AkuntanVNotaPjln> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");
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
              Navigator.of(context).pop(
                  MaterialPageRoute(builder: (context) => AkuntanMainPage()));
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

// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    ListPenjualanObat.clear();
    Future<String> data = fetchDataVPenjualanObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        ListPenjualanObat.add(pjlnObtNota);
      }
      setState(() {});
    });
  }

  Widget widgetLsPjlnObat() {
    if (ListPenjualanObat.length > 0) {
      return ExpansionTile(title: Text('Daftar Penjualan Obat'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ListPenjualanObat.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        // _timerForInter.cancel();
                        // print('timer stop');
                        // DokterVListTindakan();
                      },
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text('${ListPenjualanObat[index].nama}'),
                      subtitle: Text(
                          '${ListPenjualanObat[index].tgl_resep.substring(0, 10)}\n${ListPenjualanObat[index].jumlah} x ${numberFormatRp.format(int.parse(ListPenjualanObat[index].harga))} |  Total:Rp ${numberFormatRp.format(ListPenjualanObat[index].total_harga)}'),
                      // trailing: widgetStatusAntrean(index)
                    ),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
      );
    }
  }

  Widget widgetTotalPenjualanObat() {
    int total = 0;
    if (ListPenjualanObat.length > 0) {
      print('ListPenjualanObat.length: ${ListPenjualanObat.length}');
      for (var i = 0; i < ListPenjualanObat.length; i++) {
        // print(
        //     'ListPenjualanObat[i].total_harga: ${ListPenjualanObat[i].total_harga}');
        total += ListPenjualanObat[i].total_harga;
      }
      print(total.toString());
      return ListTile(
          title:
              Text('Total Penjualan Obat Rp ${numberFormatRp.format(total)}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Nota Penjualan"),
          ),
          drawer: widgetDrawer(),
          body: ListView(
            children: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      AkunanBacaDataPenjualanObat('2021-');
                    },
                    child: Text('lihat penjualan obat')),
              ),
              widgetLsPjlnObat(),
              // Center(
              //   child: ElevatedButton(
              //       onPressed: () {
              //         widgetTotalPenjualanObat();
              //       },
              //       child: Text('total penjualan obat')),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: widgetTotalPenjualanObat()),
              ),
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
