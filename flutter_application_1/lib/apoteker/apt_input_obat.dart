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

  var list = ["one", "two", "three", "four"];
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
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              // getTextWidgets(lsObat),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Cari Obat',
                ),
                onChanged: (value) {
                  _txtcari = value;
                  bacaData(value);
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.greenAccent,
                padding: EdgeInsets.all(5.0),
                child: ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Text('${[index + 1]}');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
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
                padding: EdgeInsets.only(top: 25),
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
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.greenAccent,
                padding: EdgeInsets.all(5.0),
                child: ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Text('${[index + 1]}');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
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
        ),
      ),
    );
  }
}
