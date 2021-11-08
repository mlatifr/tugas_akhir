import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      padding: const EdgeInsets.all(8.0),
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

  Widget widgetDropDownDebetKredit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: DropdownButton(
              hint: Text("Debet/Kredit"),
              value: valueDebetKredit,
              items: DebetKredit.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  valueDebetKredit = value;
                  print('$valueDebetKredit');
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

  TextEditingController controllerNilaiAkun = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  Widget widgetFormTransaksi() {
    return Column(
      children: [
        widgetDropDownTindakan(),
        widgetDropDownDebetKredit(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerNilaiAkun,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  controllerNilaiAkun.text = value.toString();
                  controllerNilaiAkun.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerNilaiAkun.text.length));
                });
              },
              decoration: InputDecoration(
                labelText: "Jumlah",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerKeterangan,
              onChanged: (value) {
                setState(() {
                  controllerKeterangan.text = value.toString();
                  controllerKeterangan.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerKeterangan.text.length));
                });
              },
              decoration: InputDecoration(
                labelText: "Keterangan",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget widgetTextKeranjangTransaksi() {
    if (KeranjangTransaksiPenjurnalans.length > 0) {
      return ListView.builder(
          itemCount: KeranjangTransaksiPenjurnalans.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Text(
                    'penjurnalan_id: ${KeranjangTransaksiPenjurnalans[i].penjurnalan_id}'),
                Text(
                    'daftar_akun_id: ${KeranjangTransaksiPenjurnalans[i].daftar_akun_id}'),
                Text(
                    'tgl_catat: ${KeranjangTransaksiPenjurnalans[i].tgl_catat}'),
                Text(
                    'debet: ${KeranjangTransaksiPenjurnalans[i].debet.toString()}'),
                Text(
                    'kredit: ${KeranjangTransaksiPenjurnalans[i].kredit.toString()}'),
                Text(
                    'ket_transaksi: ${KeranjangTransaksiPenjurnalans[i].ket_transaksi}'),
              ],
            );
          });
    } else {
      return Text('Keranjang masih kosong');
    }
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
              widgetFormTransaksi(),
              ElevatedButton(
                  onPressed: () {
                    AkuntanKeranjangPenjurnalan AIP =
                        AkuntanKeranjangPenjurnalan();
                    AIP.penjurnalan_id = '1';
                    AIP.daftar_akun_id = valIdAkun.toString();
                    AIP.tgl_catat = '2021-11-08';
                    if (valueDebetKredit.toString() == 'debet') {
                      AIP.kredit = '0';
                      AIP.debet = controllerNilaiAkun.text;
                    } else if (valueDebetKredit.toString() == 'kredit') {
                      AIP.debet = '0';
                      AIP.kredit = controllerNilaiAkun.text;
                    }
                    AIP.ket_transaksi = controllerKeterangan.text;
                    KeranjangTransaksiPenjurnalans.add(AIP);
                    for (var i in KeranjangTransaksiPenjurnalans) {
                      print(
                          'penjurnalan_id:i.penjurnalan_id${i.penjurnalan_id} \ndaftar_akun_id:${i.daftar_akun_id}\ntgl_catat:${i.tgl_catat}\ndebet:${i.debet}\nkredit:${i.kredit}\nket_transaksi${i.ket_transaksi}');
                    }
                    setState(() {});
                  },
                  child: Text('Tambah')),
              ElevatedButton(
                  onPressed: () {
                    KeranjangTransaksiPenjurnalans.clear();
                    setState(() {
                      widgetTextKeranjangTransaksi();
                    });
                  },
                  child: Icon(Icons.delete_outline)),
              Divider(),
              Expanded(child: widgetTextKeranjangTransaksi())
            ],
          )),
    );
  }
}
