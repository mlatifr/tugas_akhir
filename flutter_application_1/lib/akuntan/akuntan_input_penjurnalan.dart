import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/akuntan_get_daftar_akun.dart';
import 'package:flutter_application_1/akuntan/akuntan_keranjang_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_main_page.dart';
import 'package:flutter_application_1/akuntan/akuntan_page_nota_penjualan.dart';
import 'package:flutter_application_1/akuntan/akuntan_send_transaksi_penjurnalan.dart';
import 'package:flutter_application_1/main.dart';

class AkuntanInputPenjurnalan extends StatefulWidget {
  const AkuntanInputPenjurnalan({Key key}) : super(key: key);

  @override
  _AkuntanInputPenjurnalanState createState() =>
      _AkuntanInputPenjurnalanState();
}

class _AkuntanInputPenjurnalanState extends State<AkuntanInputPenjurnalan> {
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
                  value: value.idAkun,
                  child: Text(value.namaAkun),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  valIdAkun = value;
                  valueNamaAkun = AkntVDftrAkns[value - 1].namaAkun;
                  print('$valueNamaAkun');
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

  Widget widgetSelectTgl() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: controllerdate,
              onChanged: (value) {
                setState(() {
                  controllerdate.text = value.toString();
                  controllerdate.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerdate.text.length));
                  print('TextFormField controllerdate $value');
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Tanggal Transaksi',
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 10);
                      print('showDatePicker : $value');
                    });
                  });
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.white,
                  size: 24.0,
                ))
          ],
        ));
  }

  var controllerdate = TextEditingController();
  int idPenjurnalan = 0;
  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    controllerdate.text = date.toString().substring(0, 10);
    getUserId();
    fetchDataAkuntanInputBukaBukuPenjurnalan(useridMainDart).then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      idPenjurnalan = json['penjurnalan_id'];
      print('id_penjurnalan: $idPenjurnalan');
    }).then((value) => fetchDataAkuntanVDftrAkun().then((value) {
          AkntVDftrAkns.clear();
          //Mengubah json menjadi Array
          // ignore: unused_local_variable
          Map json = jsonDecode(value);
          for (var i in json['data']) {
            AkuntanVDftrAkun dvlt = AkuntanVDftrAkun.fromJson(i);
            AkntVDftrAkns.add(dvlt);
          }
          setState(() {});
        }));

    super.initState();
  }

  TextEditingController controllerNilaiAkun = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  Widget widgetFormTransaksi() {
    return Column(
      children: [
        widgetSelectTgl(),
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
          child: TextField(
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
        ElevatedButton(
            onPressed: () {
              AkuntanKeranjangPenjurnalan AIP = AkuntanKeranjangPenjurnalan();
              AIP.penjurnalan_id = idPenjurnalan.toString();
              AIP.daftar_akun_id = valIdAkun.toString();
              AIP.daftar_akun_nama = valueNamaAkun.toString();
              AIP.tgl_catat = controllerdate.text;
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
              setState(() {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('$valueNamaAkun berhasil!'),
                  duration: Duration(seconds: 2),
                ));
              });
            },
            child: Text('Tambah')),
      ],
    );
  }

  Widget widgetTxtDebetKredit(debet, kredit, i) {
    if (debet > 0) {
      return Text(
        'debet: ${KeranjangTransaksiPenjurnalans[i].debet.toString()}',
        style:
            TextStyle(backgroundColor: Colors.blueAccent, color: Colors.white),
      );
    } else if (kredit > 0) {
      return Text(
        'Kredit: ${KeranjangTransaksiPenjurnalans[i].kredit.toString()}',
        style: TextStyle(backgroundColor: Colors.red, color: Colors.white),
      );
    }
  }

  Widget widgetTextKeranjangTransaksi() {
    if (KeranjangTransaksiPenjurnalans.length > 0) {
      return Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: KeranjangTransaksiPenjurnalans.length,
              itemBuilder: (context, i) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Text(
                                '${KeranjangTransaksiPenjurnalans[i].daftar_akun_nama}'),
                            Text(
                                'tgl ${KeranjangTransaksiPenjurnalans[i].tgl_catat}'),
                            widgetTxtDebetKredit(
                                int.parse(
                                    KeranjangTransaksiPenjurnalans[i].debet),
                                int.parse(
                                    KeranjangTransaksiPenjurnalans[i].kredit),
                                i),
                            Text(
                                'ket_transaksi: ${KeranjangTransaksiPenjurnalans[i].ket_transaksi}'),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          KeranjangTransaksiPenjurnalans.removeAt(i);
                          setState(() {
                            widgetTextKeranjangTransaksi();
                          });
                        },
                        child: Icon(Icons.delete))
                  ],
                );
              }),
        ],
      );
    } else {
      return Expanded(child: Center(child: Text('Keranjang masih kosong')));
    }
  }

  Function functionSimpanPenjurnalan() {
    if (KeranjangTransaksiPenjurnalans.isNotEmpty) {
      for (var i = 0; i < KeranjangTransaksiPenjurnalans.length; i++) {
        fetchDataAkuntanInputTransaksiPenjurnalan(
                KeranjangTransaksiPenjurnalans[i].penjurnalan_id,
                KeranjangTransaksiPenjurnalans[i].daftar_akun_id,
                KeranjangTransaksiPenjurnalans[i].tgl_catat,
                KeranjangTransaksiPenjurnalans[i].debet,
                KeranjangTransaksiPenjurnalans[i].kredit,
                KeranjangTransaksiPenjurnalans[i].ket_transaksi)
            .then((value) {
          Map json = jsonDecode(value);
          if (json['result'].toString() == 'success') {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(value),
              duration: Duration(milliseconds: 100),
            ));
            KeranjangTransaksiPenjurnalans.clear();
            setState(() {
              widgetTextKeranjangTransaksi();
              Navigator.pop(context);
            });
          } else if (json['result'].toString() == 'fail') {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  '$value',
                  style: TextStyle(fontSize: 14),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('ok')),
                ],
              ),
            );
          }
        });
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget widgetListViewBodyPage() {
    return ListView(
      children: [
        ExpansionTile(
            title: Text(
              'Input Transaksi',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            children: [widgetFormTransaksi()]),
        ExpansionTile(
            title: Text(
              'Keranjang Transaksi',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            children: [widgetTextKeranjangTransaksi()]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'WARNING!\nData yg sudah di simpan tidak bisa di edit lagi',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            functionSimpanPenjurnalan();
                            Navigator.pop(context);
                          },
                          child: Text('ok')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                    ],
                  ),
                );
              },
              child: Text('simpan')),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Input Penjurnalan"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: widgetListViewBodyPage()),
    );
  }
}
