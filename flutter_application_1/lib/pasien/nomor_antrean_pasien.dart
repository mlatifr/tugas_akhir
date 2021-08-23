import 'package:flutter/material.dart';

class AntreanPasien extends StatefulWidget {
  const AntreanPasien({Key key}) : super(key: key);

  @override
  _AntreanPasienState createState() => _AntreanPasienState();
}

class _AntreanPasienState extends State<AntreanPasien> {
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
      ),
    );
  }
}
