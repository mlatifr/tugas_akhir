import 'dart:convert';

import 'package:flutter/material.dart';
import 'kasir_get_resep.dart';
import 'kasir_get_tindakan.dart';
import 'package:intl/intl.dart';

var numberFormatRpResep, numberFormatRpTindakan;
var cekInitState = 1;

class KasirDetailPasien extends StatefulWidget {
  var visitId, namaPasien;
  KasirDetailPasien({Key key, this.visitId, this.namaPasien}) : super(key: key);

  @override
  _KasirDetailPasienState createState() => _KasirDetailPasienState();
}

class _KasirDetailPasienState extends State<KasirDetailPasien> {
  @override
  void initState() {
    print('init state $cekInitState');
    KasirBacaDataVListTindakan(widget.visitId);
    KasirBacaDataVResep(widget.visitId);
    super.initState();
  }

  // ignore: non_constant_identifier_names
  KasirBacaDataVResep(pVisitId) {
    KVKRs.clear();
    Future<String> data = fetchDataDokterVKeranjangResep(pVisitId);
    data.then((value) {
      numberFormatRpResep = new NumberFormat("#,##0", "id_ID");
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
      numberFormatRpTindakan = new NumberFormat("#,##0", "id_ID");
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

  int totalBiayaObat = 0;
  var hargaKaliObat = [];
  Widget widgetKeranjangResep() {
    hargaKaliObat.clear();
    totalBiayaObat = 0;
    if (KVKRs.length > 0) {
      for (var i = 0; i < KVKRs.length; i++) {
        hargaKaliObat
            .add(int.parse(KVKRs[i].hargaJual) * int.parse(KVKRs[i].jumlah));
        // totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
      }
      for (var i = 0; i < hargaKaliObat.length; i++) {
        // hargaKaliObat.add(KVKRs[i].hargaJual * KVKRs[i].jumlah);
        totalBiayaObat = totalBiayaObat + hargaKaliObat[i];
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
                          '${numberFormatRpResep.format(int.parse(KVKRs[index].hargaJual))}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${numberFormatRpResep.format(hargaKaliObat[index])}',
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
                    'Total: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${numberFormatRpResep.format(totalBiayaObat)}',
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

  Widget widgetInputPembayaran() {
    if (KVKRs.length > 0) {
      return Column(
        children: [
          Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Text(
                    'Total Pembayaran: ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rp ${numberFormatRpResep.format(totalBiayaTindakan + totalBiayaObat)}',
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
        children: [Text('Input Pembayaran: '), CircularProgressIndicator()],
      );
    }
  }

  int totalBiayaTindakan = 0;
  Widget widgetKeranjangTindakan() {
    totalBiayaTindakan = 0;
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
                          '${numberFormatRpTindakan.format(KVKTs[index].harga)}',
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
                    '${numberFormatRpTindakan.format(totalBiayaTindakan)}',
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
          title: Text('Detail Biaya'),
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
                              '${widget.namaPasien}',
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
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widgetInputPembayaran()),
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
