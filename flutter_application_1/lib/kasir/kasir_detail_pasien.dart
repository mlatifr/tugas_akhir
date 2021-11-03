import 'dart:convert';

import 'package:flutter/material.dart';
import 'kasir_get_resep.dart';
import 'kasir_get_tindakan.dart';

class KasirDetailPasien extends StatefulWidget {
  var visitId;
  KasirDetailPasien({Key key, this.visitId}) : super(key: key);

  @override
  _KasirDetailPasienState createState() => _KasirDetailPasienState();
}

class _KasirDetailPasienState extends State<KasirDetailPasien> {
  @override
  void initState() {
    KasirBacaDataVListTindakan(widget.visitId);
    KasirBacaDataVResep(widget.visitId);
    super.initState();
  }

  // ignore: non_constant_identifier_names
  KasirBacaDataVResep(pVisitId) {
    KVKRs.clear();
    Future<String> data = fetchDataDokterVKeranjangResep(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
        KasirVKeranjangResep kvt = KasirVKeranjangResep.fromJson(i);
        KVKRs.add(kvt);
      }
      setState(() {
        widgetKeranjangResep();
      });
    });
  }

  KasirBacaDataVListTindakan(pVisitId) {
    KVKTs.clear();
    Future<String> data = fetchDataDokterVKeranjangTindakan(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print('fetchDataDokterVKeranjangTindakan: ${i.toString()}');
        KasirVKeranjangTindakan kvt = KasirVKeranjangTindakan.fromJson(i);
        KVKTs.add(kvt);
      }
      setState(() {
        widgetKeranjangTindakan();
      });
    });
  }

  Widget widgetKeranjangResep() {
    int totalBiayaTindakan = 0;
    int hargaKaliObat = 0;
    if (KVKRs.length > 0) {
      for (var i = 0; i < KVKRs.length; i++) {
        hargaKaliObat = KVKRs[i].hargaJual * KVKRs[i].jumlah;
        totalBiayaTindakan = totalBiayaTindakan + KVKRs[i].jumlah;
      }
      return Column(
        children: [
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Nama',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Jumlah',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga Satuan',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga Total',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: KVKRs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          ' $index| ${KVKRs[index].namaObat}',
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '${KVKRs[index].jumlah}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${KVKRs[index].hargaJual}',
                          textAlign: TextAlign.center,
                        ),
                        // Text(
                        //   '${hargaKaliObat.toString()}',
                        //   textAlign: TextAlign.center,
                        // ),
                      ]),
                    ]);
              }),
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$totalBiayaTindakan',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ],
      );
    } else {
      return Row(
        children: [Text('Keranjang Tindakan: '), CircularProgressIndicator()],
      );
    }
  }

  Widget widgetKeranjangTindakan() {
    int totalBiayaTindakan = 0;
    if (KVKTs.length > 0) {
      for (var i = 0; i < KVKTs.length; i++) {
        totalBiayaTindakan = totalBiayaTindakan + KVKTs[i].harga;
      }
      return Column(
        children: [
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Nama',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Tindakan',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Harga',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: KVKTs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          '${KVKTs[index].nama}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${KVKTs[index].mtSisi}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${KVKTs[index].harga}',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ]);
              }),
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    '',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$totalBiayaTindakan',
                    textAlign: TextAlign.center,
                  ),
                ]),
              ]),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
        ],
      );
    } else {
      return Row(
        children: [Text('Keranjang Tindakan: '), CircularProgressIndicator()],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Input Pemeriksaan'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '',
                              style: TextStyle(fontSize: 22),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                              title: Text(
                                'Tindakan',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                              children: [
                                widgetKeranjangTindakan(),
                              ]),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionTile(
                                title: Text(
                                  'Resep',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                                children: [widgetKeranjangResep()])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
