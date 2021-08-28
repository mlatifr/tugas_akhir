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
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Text('${[index]}');
                }),
          ],
        ),
      ),
    );
  }
}
