import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  main();
}

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
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            // onPressed: () => Navigator.of(context).pop(),
            onPressed: () => doLogout(),
          ),
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
