import 'package:flutter/material.dart';

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

class RiwayatPeriksaPasien extends StatefulWidget {
  const RiwayatPeriksaPasien({Key key}) : super(key: key);

  @override
  _RiwayatPeriksaPasienState createState() => _RiwayatPeriksaPasienState();
}

class _RiwayatPeriksaPasienState extends State<RiwayatPeriksaPasien> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Riwayat Periksa'),
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
                Text('Profil'),
                Text('Rekam Medis'),
                Text('Nama'),
                Text('Usia'),
                _buildPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
