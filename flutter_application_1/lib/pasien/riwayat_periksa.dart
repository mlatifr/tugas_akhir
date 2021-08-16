import 'package:flutter/material.dart';

class RiwayatPeriksaPasien extends StatefulWidget {
  const RiwayatPeriksaPasien({Key key}) : super(key: key);

  @override
  _RiwayatPeriksaPasienState createState() => _RiwayatPeriksaPasienState();
}

class _RiwayatPeriksaPasienState extends State<RiwayatPeriksaPasien> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Periksa'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
