import 'package:flutter/material.dart';
import 'package:flutter_application_1/dokter/dr_get_list_tindakan.dart';

import 'dr_antrean_pasien.dart';

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
  final namaPasien;

  const DrRiwayatPeriksaPasien({Key key, this.namaPasien}) : super(key: key);

  @override
  _DrRiwayatPeriksaPasienState createState() => _DrRiwayatPeriksaPasienState();
}

class _DrRiwayatPeriksaPasienState extends State<DrRiwayatPeriksaPasien> {
  final List<Item> _data = generateItems(8);
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              color: Colors.green[50],
              child: Column(
                children: [
                  TextFormField(
                      enabled: false,
                      initialValue: 'tidak  ada',
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
                  TextFormField(
                      enabled: false,
                      initialValue: 'tidak ada',
                      decoration: InputDecoration(
                        labelText: "Riwayat Alergi",
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
                  TextFormField(
                      enabled: false,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(
                          color: Colors.yellow,
                          child: TextFormField(
                              enabled: false,
                              initialValue: 'tidak ada',
                              decoration: InputDecoration(
                                labelText: "tindakan mata kiri",
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
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Container(
                          color: Colors.yellow[50],
                          child: TextFormField(
                              enabled: false,
                              maxLines: 10,
                              initialValue:
                                  '1 \n 2 \n 3 \n 4 \n 5 \n 6 \n 7 \n 8 \n 9 \n 10',
                              decoration: InputDecoration(
                                labelText: "tindakan mata kanan",
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
                      ),
                    ],
                  ),
                  TextFormField(
                      enabled: false,
                      initialValue: 'tidak ada',
                      decoration: InputDecoration(
                        labelText: "Resep",
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
                ],
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  var refreshListTindakan = false;
  refreshListTdkn() {
    if (refreshListTindakan == true) {
      refreshListTindakan = true;
      print(refreshListTindakan);
    }
  }

    var listNamaCheckbox = [];
  mapingValues() {
    for (var i = 0; i < DVLTs.length; i++) {
      // print(DVLTs[i].namaTindakan);
      var productMap = {DVLTs[i].namaTindakan: false};
      listNamaCheckbox.add(productMap);
    }
    for (var item in listNamaCheckbox) {
      print(item);
    }
  }
  
  Map<String, bool> valuesRight = {
    'Auto Refraksi': true,
    'Trial Lens': false,
    'Slit Lamp': false,
    'TOnometri Schiot': false,
    'Fundoscopy': false,
  };

  Map<String, bool> valuesLeft = {
    'Auto Refraksi': true,
    'Trial Lens': false,
    'Slit Lamp': false,
    'TOnometri Schiot': false,
    'Fundoscopy': false,
  };

  var _valueButton = true;
  @override
  Widget build(BuildContext context) {
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
        body: ListView(
          children: <Widget>[
            Container(
                color: Colors.yellow[50],
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: DVLTs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(
                            '${index + 1} ${DVLTs[index].namaTindakan}',
                            style: TextStyle(fontSize: 20),
                          ),
                          Divider(),
                        ],
                      );
                    })),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // DokterBacaDataVListTindakan().then(refreshListTdkn());
                    mapingValues();
                  },
                  child: Text('button'),
                ),
                Text('Profil'),
                Text('Rekam Medis'),
                Text('Nama'),
                Text('Usia'),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              initialValue: 'tidak ada',
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
                                labelText: "Riwayat Alergi",
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
                        Container(
                            color: Colors.yellow[50],
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: DVLTs.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(
                                      '${index + 1} ${DVLTs[index].namaTindakan}',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    value: _valueButton,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _valueButton = value;
                                      });
                                      print('value: $_valueButton');
                                    },
                                  );
                                })),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              initialValue: 'Cari',
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
                                    MediaQuery.of(context).size.height * 0.01)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                              border: TableBorder
                                  .all(), // Allows to add a border decoration around your table
                              children: [
                                TableRow(children: [
                                  Text('Obat'),
                                  Text('Btl/Strip'),
                                  Text('Dosis'),
                                  Text('Atrn Pakai'),
                                ]),
                                TableRow(children: [
                                  Text(
                                    'Insto',
                                  ),
                                  Text('3'),
                                  Text('3x1'),
                                  Text('Setelah maem'),
                                ]),
                                TableRow(children: [
                                  Text('Catarlent'),
                                  Text('3'),
                                  Text('3x1'),
                                  Text('Setelah maem'),
                                ]),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
