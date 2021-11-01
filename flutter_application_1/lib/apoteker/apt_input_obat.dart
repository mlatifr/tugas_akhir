import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_get_list_obat.dart';
import 'package:http/http.dart';
import 'apt_get_resep_pasien_detail.dart';

class AptInputObat extends StatefulWidget {
  final AptkrId, namaPasien, visitId;

  const AptInputObat({Key key, this.AptkrId, this.namaPasien, this.visitId})
      : super(key: key);

  @override
  _AptInputObatState createState() => _AptInputObatState();
}

class _AptInputObatState extends State<AptInputObat> {
// ignore: non_constant_identifier_names
  ApotekerBacaDataVKeranjangResep(
      pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) {
    AVKOs.clear();
    Future<String> data = fetchDataApotekerInputResepObat(
        pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId);
    data.then((value) {
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'success') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Obat berhasil ditambah ke resep',
              style: TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    controllerJumlah.clear();
                    controllerDosis.clear();
                    setState(() {
                      widgetListObats();
                    });
                    Navigator.pop(
                      context,
                      'ok',
                    );
                  },
                  child: Text('ok')),
            ],
          ),
        );
        for (var i in json['data']) {
          ApotekerVKeranjangObat keranjangObatDokter =
              ApotekerVKeranjangObat.fromJson(i);
          AVKOs.add(keranjangObatDokter);
          print('AVKOs[length]: ${AVKOs.length}');
        }
        setState(() {
          //widgetKeranjangObatApoteker();
        });
      }
    });
  }

  // ignore: non_constant_identifier_names
  ApotekerBacaDataVKeranjangResepDokter(pVisitId) {
    AVKODrs.clear();
    Future<String> data = fetchDataDokterKeranjangObat(pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ApotekerVKeranjangObatDokter keranjangObatDokter =
            ApotekerVKeranjangObatDokter.fromJson(i);
        AVKODrs.add(keranjangObatDokter);
      }
      setState(() {
        widgetListObats();
      });
    });
  }

  // ignore: non_constant_identifier_names
  ApotekerBacaDataVListObat(pNamaObat) {
    AVLOs.clear();
    Future<String> data = fetchDataApotekerVListObat(pNamaObat);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        ApotekerrVListObat avlo = ApotekerrVListObat.fromJson(i);
        AVLOs.add(avlo);
      }
      setState(() {
        widgetListObats();
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
              ApotekerBacaDataVListObat(controllerCariObat.text);
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

  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerDosis = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile
  // ignore: missing_return
  Widget widgetListObats() {
    if (AVLOs.length > 0) {
      return ListView.builder(
          key: Key(
              'builder ${selected.toString()}'), //agar yg terbuka hanya bisa 1 ListTile
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: AVLOs.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      ExpansionTile(
                          key: Key(index
                              .toString()), //agar yg terbuka hanya bisa 1 ListTile
                          initiallyExpanded: index ==
                              selected, //agar yg terbuka hanya bisa 1 ListTile
                          onExpansionChanged: ((newState) {
                            if (newState)
                              setState(() {
                                selected = index;
                              });
                            else
                              setState(() {
                                selected = -1;
                              });
                          }),
                          title: Text(
                            '${AVLOs[index].obatNama} : ${AVLOs[index].obatStok}',
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                          children: [
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
                                        onChanged: (value) {
                                          setState(() {
                                            controllerDosis.text =
                                                value.toString();
                                            controllerDosis.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controllerDosis
                                                            .text.length));
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
                                  ApotekerBacaDataVKeranjangResep(
                                      AptkrRspId,
                                      AVLOs[index].obatId,
                                      controllerDosis.text,
                                      controllerJumlah.text,
                                      widget.visitId);
                                  fetchDataApotekerInputResepObat(
                                          AptkrRspId,
                                          AVLOs[index].obatId,
                                          controllerDosis.text,
                                          controllerJumlah.text,
                                          widget.visitId)
                                      .then((value) {});
                                  // DokterBacaDataVKeranjangObat(widget.visitId);
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

  Widget widgetKeranjangObatHeader() {
    return Padding(
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
    );
  }

  Widget widgetKeranjangObatBody() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: AVKODrs.length,
          itemBuilder: (context, index) {
            return Table(
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Text(
                      '${AVKODrs[index].nama}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${AVKODrs[index].jumlah}',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${AVKODrs[index].dosis}',
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ]);
          }),
    );
  }

  var AptkrRspId;
  // ignore: non_constant_identifier_names
  ApotekerBacaDataRspVst() {
    AptkrRspId = '';
    Future<String> data = fetchDataApotekerInputRspVst(
      widget.visitId,
      widget.AptkrId,
      DateTime.now().toString().substring(0, 10),
    );
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      AptkrRspId = json['id_resep_apoteker'].toString();
      print('ApotekerBacaDataRspVst(): $AptkrRspId');
      // for (var i in json['data']) {
      //   print(i);
      //   ApotekerVAntrean dva = ApotekerVAntrean.fromJson(i);
      // }
      setState(() {});
    });
  }

// ignore: non_constant_identifier_names
  ApotekerBacaInputResepObat(pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) {
    // AptkrRspId = '';
    Future<String> data = ApotekerBacaInputResepObat(
        pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      // AptkrRspId = json['id_resep_apoteker'].toString();
      // print('ApotekerBacaDataRspVst(): $AptkrRspId');
      for (var i in json['data']) {
        print(i);
        // ApotekerVAntrean dva = ApotekerVAntrean.fromJson(i);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    ApotekerBacaDataRspVst();
    ApotekerBacaDataVKeranjangResepDokter(widget.visitId);
    controllerCariObat.clear();
    ApotekerBacaDataVListObat(controllerCariObat.text);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AVKODrs.length > 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Input Resep'),
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
                          widgetKeranjangObatHeader(),
                          widgetKeranjangObatBody(),
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
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Resep: ${widget.namaPasien}'),
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
