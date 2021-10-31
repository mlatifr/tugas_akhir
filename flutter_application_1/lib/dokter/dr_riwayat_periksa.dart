import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_get_list_tindakan.dart';

import 'dr_get_list_obat.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Tanggal Periksa $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class DrRiwayatPeriksaPasien extends StatefulWidget {
  final namaPasien, visitId, keluhan;

  const DrRiwayatPeriksaPasien(
      {Key key, this.namaPasien, this.visitId, this.keluhan})
      : super(key: key);

  @override
  _DrRiwayatPeriksaPasienState createState() => _DrRiwayatPeriksaPasienState();
}

class _DrRiwayatPeriksaPasienState extends State<DrRiwayatPeriksaPasien> {
  // ignore: non_constant_identifier_names
  DokterBacaDataVKeranjangTindakan(pVisitId) {
    DVKTs.clear();
    Future<String> data = fetchDataDokterVKeranjangTindakan(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'error') {
        DVKTs.clear();
        print('json[result]: ${json['result']}');
      } else {
        for (var i in json['data']) {
          DokterVKeranjangTindakan keranjangObat =
              DokterVKeranjangTindakan.fromJson(i);
          DVKTs.add(keranjangObat);
        }
      }
      setState(() {
        widgetKeranjangTindakan();
      });
    });
  }

  // ignore: non_constant_identifier_names
  DokterBacaDataVKeranjangObat(pVisitId) {
    DVLKOs.clear();
    Future<String> data = fetchDataDokterKeranjangObat(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        DokterVKeranjangObat keranjangObat = DokterVKeranjangObat.fromJson(i);
        DVLKOs.add(keranjangObat);
      }
      setState(() {
        widgetListObats();
        for (var i = 0; i < DVLKOs.length; i++) {
          // print(
          //     'id: ${DVLOs[i].obatId}\nnama: ${DVLOs[i].obatNama}\nstok: ${DVLOs[i].obatStok}\n\n\n\n\n\n');
        }
      });
    });
  } // ignore: non_constant_identifier_names

  DokterBacaDataVListObat(pNamaObat) {
    DVLOs.clear();
    Future<String> data = fetchDataDokterVListObat(pNamaObat);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        DokterVListObat dvlo = DokterVListObat.fromJson(i);
        DVLOs.add(dvlo);
      }
      setState(() {
        widgetListObats();
        for (var i = 0; i < DVLOs.length; i++) {
          // print(
          //     'id: ${DVLOs[i].obatId}\nnama: ${DVLOs[i].obatNama}\nstok: ${DVLOs[i].obatStok}\n\n\n\n\n\n');
        }
      });
    });
  }

  // ignore: non_constant_identifier_names
  DokterBacaDataVListTindakan() {
    DVLTs.clear();
    Future<String> data = fetchDataDokterVListTindakan();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        // print('DokterBacaDataVListTindakan: ${i}');
        DokterVListTindakan dvlt = DokterVListTindakan.fromJson(i);
        DVLTs.add(dvlt);
      }
      setState(() {
        widgetListTindakanKiri();
        widgetListTindakanKanan();
        listValueCheckKiri.clear();
        listValueCheckKanan.clear();
        for (var i = 0; i < DVLTs.length; i++) {
          listValueCheckKiri.add(false);
          listValueCheckKanan.add(false);
          // print('lValueCHeckLength ${listValueCheckKiri.length}');
        }
      });
    });
  }

  Widget widgetCariObat() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariObat,
              onChanged: (value) {
                setState(() {
                  controllerCariObat.text = value.toString();
                  controllerCariObat.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerCariObat.text.length));
                  // print(value.toString());
                });
              },
              decoration: InputDecoration(
                labelText: "Resep",
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.search),
                ),
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
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: TextButton(
            onPressed: () {
              DokterBacaDataVListObat(controllerCariObat.text);
            },
            child: Text(
              'Cari',
            ),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.01)),
          ),
        ),
      ],
    );
  }

  // ignore: missing_return
  Widget widgetListObats() {
    if (DVLOs.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: DVLOs.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      ExpansionTile(
                          title: Text(
                            '${DVLOs[index].obatNama}',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'STOK: ${DVLOs[index].obatStok}',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        enabled: true,
                                        controller: controllerJumlah,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            controllerJumlah.text =
                                                value.toString();
                                            controllerJumlah.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controllerJumlah
                                                            .text.length));
                                            // print(value.toString());
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Jumlah",
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        enabled: true,
                                        controller: controllerDosis,
                                        // keyboardType: TextInputType.number,
                                        // inputFormatters: <TextInputFormatter>[
                                        //   FilteringTextInputFormatter.digitsOnly
                                        // ],
                                        onChanged: (value) {
                                          setState(() {
                                            controllerDosis.text =
                                                value.toString();
                                            controllerDosis.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controllerDosis
                                                            .text.length));
                                            // print(value.toString());
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Dosis",
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  fetchDataDokterInputResepObat(
                                      DVLOs[index].obatId,
                                      controllerDosis.text,
                                      controllerJumlah.text,
                                      widget.visitId);
                                  DokterBacaDataVKeranjangObat(widget.visitId);
                                },
                                child: Text('tambah'),
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height *
                                            0.01)),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerDosis = TextEditingController();
  TextEditingController controllerKeluhan = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  final List<Item> _data = generateItems(8);

  @override
  void initState() {
    controllerKeluhan.text = widget.keluhan;
    controllerKeluhan.addListener(() {
      setState(() {});
    });
    DokterBacaDataVListTindakan();
    DokterBacaDataVListObat('');
    DokterBacaDataVKeranjangObat(widget.visitId);
    for (var index = 0; index < DVKTs.length; index++) {
      fetchDataDokterInputTindakanBatal(
              widget.visitId, DVKTs[index].tindakan_id, 'kiri')
          .then((value) => DokterBacaDataVKeranjangTindakan(widget.visitId));
      fetchDataDokterInputTindakanBatal(
              widget.visitId, DVKTs[index].tindakan_id, 'kanan')
          .then((value) => DokterBacaDataVKeranjangTindakan(widget.visitId));
    }
    super.initState();
  }

  @override
  void dispose() {
    controllerKeluhan.dispose();
    super.dispose();
  }

  var listValueCheckKiri = [false, true];
  var listValueCheckKanan = [false, true];
  Widget widgetListTindakanKiri() {
    if (DVLTs != null) {
      return Column(
        children: [
          Text(
            'Mata Kiri:',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: DVLTs.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    '${index + 1} ${DVLTs[index].namaTindakan}',
                    style: TextStyle(fontSize: 14),
                  ),
                  value: listValueCheckKiri[index],
                  onChanged: (bool value) {
                    setState(() {
                      listValueCheckKiri[index] = value;
                      if (value == true) {
                        fetchDataDokterInputTindakan(
                                widget.visitId, DVLTs[index].idTindakan, 'kiri')
                            .then((value) => DokterBacaDataVKeranjangTindakan(
                                widget.visitId));
                      } else if (value == false) {
                        fetchDataDokterInputTindakanBatal(
                                widget.visitId, DVLTs[index].idTindakan, 'kiri')
                            .then((value) => DokterBacaDataVKeranjangTindakan(
                                widget.visitId));
                      }
                      // DokterBacaDataVKeranjangTindakan(widget.visitId);
                    });
                  },
                );
              }),
        ],
      );
    }
  }

  Widget widgetListTindakanKanan() {
    return Container(
        color: Colors.yellow[50],
        child: Column(
          children: [
            Text(
              'Mata Kanan:',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DVLTs.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      '${index + 1} ${DVLTs[index].namaTindakan}',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: listValueCheckKanan[index],
                    onChanged: (bool value) {
                      setState(() {
                        listValueCheckKanan[index] = value;
                        if (value == true) {
                          fetchDataDokterInputTindakan(widget.visitId,
                                  DVLTs[index].idTindakan, 'kanan')
                              .then((value) => DokterBacaDataVKeranjangTindakan(
                                  widget.visitId));
                        } else if (value == false) {
                          fetchDataDokterInputTindakanBatal(widget.visitId,
                                  DVLTs[index].idTindakan, 'kanan')
                              .then((value) => DokterBacaDataVKeranjangTindakan(
                                  widget.visitId));
                        }
                      });
                    },
                  );
                }),
          ],
        ));
  }

  Widget widgetKeranjangTindakan() {
    if (DVKTs.length > 0) {
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
                ]),
              ]),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: DVKTs.length,
              itemBuilder: (context, index) {
                return Table(
                    border: TableBorder
                        .all(), // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Text(
                          '${DVKTs[index].namaTindakan}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${DVKTs[index].mataSisiTindakan}',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    ]);
              }),
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
    if (DVLTs.length > 0) {
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
                                '${widget.namaPasien}',
                                style: TextStyle(fontSize: 22),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                // initialValue: widget.keluhan,
                                controller: controllerKeluhan,
                                decoration: InputDecoration(
                                  labelText: "keluhan",
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
                                initialValue: 'tidak ada',
                                decoration: InputDecoration(
                                  labelText: "anamnesis",
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
                            child: ExpansionTile(
                                title: Text(
                                  'Input Tindakan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                                children: [
                                  widgetKeranjangTindakan(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: widgetListTindakanKiri(),
                                      ),
                                      Expanded(
                                        child: widgetListTindakanKanan(),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                          // Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: widgetCariObat()),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                  title: Text(
                                    'Input Resep',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  children: [
                                    widgetCariObat(),
                                    widgetListObats()
                                  ])),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text('tambah'),
                              style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.01)),
                            ),
                          ),
                          // widgetKeranjangObat
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Table(
                                border: TableBorder
                                    .all(), // Allows to add a border decoration around your table
                                children: [
                                  TableRow(children: [
                                    Text(
                                      'Obat',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Jumlah',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Dosis',
                                      textAlign: TextAlign.center,
                                    ),
                                  ]),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: DVLKOs.length,
                                itemBuilder: (context, index) {
                                  return Table(
                                      border: TableBorder
                                          .all(), // Allows to add a border decoration around your table
                                      children: [
                                        TableRow(children: [
                                          Text(
                                            '${DVLKOs[index].obatNama}',
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '${DVLKOs[index].obatJumlah}',
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '${DVLKOs[index].obatDosis}',
                                            textAlign: TextAlign.center,
                                          ),
                                        ]),
                                      ]);
                                }),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Table(
                          //       border: TableBorder
                          //           .all(), // Allows to add a border decoration around your table
                          //       children: [
                          //         TableRow(children: [
                          //           Text('Obat'),
                          //           Text('Jumlah'),
                          //           Text('Dosis'),
                          //         ]),
                          //         TableRow(children: [
                          //           Text(
                          //             'Insto',
                          //           ),
                          //           Text('3'),
                          //           Text('3x1'),
                          //         ]),
                          //         TableRow(children: [
                          //           Text('Catarlent'),
                          //           Text('3'),
                          //           Text('3x1'),
                          //         ]),
                          //       ]),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // widgetBuildPanel(),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Riwayat Periksa: ${widget.namaPasien}'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
}
