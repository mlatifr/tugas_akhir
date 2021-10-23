import 'package:flutter/material.dart';

class AntreanPasien extends StatefulWidget {
  var nomor_antrean, antrean_sekarang;
  AntreanPasien({Key key, this.nomor_antrean, this.antrean_sekarang})
      : super(key: key);

  @override
  _AntreanPasienState createState() => _AntreanPasienState();
}

class _AntreanPasienState extends State<AntreanPasien> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Antrean'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            Center(
                child: Text(
              "nomor antrean anda: \n",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            )),
            Center(
                child: Text(
              widget.nomor_antrean.toString(),
              style: TextStyle(fontSize: 88, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            )),
            Center(
                child: Text(
              'antrean saat ini: ',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )),
            Center(
                child: Text(
              widget.antrean_sekarang.toString(),
              style: TextStyle(color: Colors.black38, fontSize: 50),
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }
}
