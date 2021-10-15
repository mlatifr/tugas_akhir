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
  RiwayatPeriksaPasien({Key key}) : super(key: key);

  @override
  _RiwayatPeriksaPasienState createState() => _RiwayatPeriksaPasienState();
}

class _RiwayatPeriksaPasienState extends State<RiwayatPeriksaPasien> {
  @override
  // untuk membaca data diawal build page nya
  void initState() {
    super.initState();
    // bacaData();
  }
  // Future getProjectDetails() async {
  //   List<Item> _data = await generateItems(30);
  //   return _data;
  // }

  // Widget ftrBuilder() {
  //   return FutureBuilder(
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting &&
  //           snapshot.hasData == null) {
  //         return CircularProgressIndicator();
  //       } else {
  //         return Text('done');
  //       }
  //     },
  //     future: getProjectDetails(),
  //   );
  // }

  List<Item> _data = generateItems(1000);
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        print('render expansion');
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                textAlign: TextAlign.center,
              ),
            );
          },
          body: Padding(
            padding: EdgeInsets.all(25.0),
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
    print('render navbar');
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
                // ftrBuilder(),
                _buildPanel(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
