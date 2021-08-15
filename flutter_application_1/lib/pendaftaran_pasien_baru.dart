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
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
              labelText: "NIK: Nomor Induk Kependudukan",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Nama Lengkap",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Sandi",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Ulangi Sandi",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Alamat",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Tempat Lahir",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Tanggal Lahir",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Status Perkawinan",
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Telepon",
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
    );
  }
}
