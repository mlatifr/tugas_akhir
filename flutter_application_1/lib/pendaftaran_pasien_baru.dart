import 'package:flutter/material.dart';

class DaftarPasienBaru extends StatefulWidget {
  const DaftarPasienBaru({Key key}) : super(key: key);

  @override
  _DaftarPasienBaruState createState() => _DaftarPasienBaruState();
}

class _DaftarPasienBaruState extends State<DaftarPasienBaru> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pendaftaran Pasien Baru'),
        ),
        body: ListView(
          children: <Widget>[
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
