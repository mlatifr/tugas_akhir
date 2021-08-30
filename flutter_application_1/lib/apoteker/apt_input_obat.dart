import 'package:flutter/material.dart';

List lsObat = [
  '1 obat',
  '2 obat',
  '3 insto',
  '4 rotho',
  '5 catarlent',
  '6 sehat mata',
  '7 mataku',
  '8 matamu',
  '9 mata-mata',
];
var _txtcari;
List hasilCari = ['kosong'];
bacaData(pCari) {
  for (var item in lsObat) {
    if (item.contains(pCari)) {
      print(item);
      hasilCari.add(item);
    }
  }
}

tampilkanData() {
  if (hasilCari != null) {
    for (var item in hasilCari) {
      hasilCari.add(item);
    }
  } else {
    return Text('kosong');
  }
}

class AptInputObat extends StatefulWidget {
  var namaPasien;
  AptInputObat({Key key, this.namaPasien}) : super(key: key);

  @override
  _AptInputObatState createState() => _AptInputObatState();
}

class _AptInputObatState extends State<AptInputObat> {
  @override
  void initState() {
    super.initState();
    //bacaData(); ditaruh disini agar saat di buka, data nda dipanggil terus
    // bacaData();
  }

  var lsObatOne = [
    "obat one",
    "obat two",
    "obat three",
    "obat four",
    "obat four",
    "obat four",
    "obat four",
    "obat four",
    "obat four",
    "obat four"
  ];
  Widget getTextWidgets(List<dynamic> strings) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.greenAccent,
      padding: EdgeInsets.all(5.0),
      child: ListView(
          children:
              strings.map((item) => Container(child: Text(item))).toList()),
    );
  }

  Widget pasienNull() {
    if (widget.namaPasien == null) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                // icon: Icon(Icons.search),
                labelText: 'Nama Pasien',
              ),
              onChanged: (value) {
                _txtcari = value;
                bacaData(value);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                // icon: Icon(Icons.search),
                labelText: 'Alamat',
              ),
              onChanged: (value) {
                _txtcari = value;
                bacaData(value);
              },
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Input Obat: ${widget.namaPasien}'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                pasienNull(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      labelText: 'Cari Obat',
                    ),
                    onChanged: (value) {
                      _txtcari = value;
                      bacaData(value);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.greenAccent[100],
                  child: ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: lsObatOne.length,
                    itemBuilder: (context, index) {
                      return Text('${lsObatOne[index]}');
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        // doLogin();
                      },
                      child: Text(
                        'Tambah',
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.lightGreen,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        semanticLabel: 'Keranjang',
                      ),
                      Text('Keranjang'),
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  // height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.greenAccent[200],
                  child: Table(
                      border: TableBorder
                          .all(), // Allows to add a border decoration around your table
                      children: [
                        TableRow(children: [
                          Text('Nama'),
                          Text('Satuan'),
                          Text('Jumlah'),
                          Text('Aturan Pakai'),
                          Text('Hapus'),
                        ]),
                      ]),
                ),
                Container(
                  // padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.greenAccent[100],
                  child: ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: lsObat.length,
                    itemBuilder: (context, index) {
                      return Table(
                          border: TableBorder
                              .all(), // Allows to add a border decoration around your table
                          children: [
                            TableRow(children: [
                              Text(
                                '${lsObat[index]}',
                              ),
                              Text(''),
                              Text('3x1'),
                              Text('Setelah maem'),
                              Icon(
                                Icons.delete,
                                color: Colors.red[200],
                              ),
                            ]),
                          ]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // padding: EdgeInsets.only(top: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        // doLogin();
                      },
                      child: Text(
                        'Simpan',
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
