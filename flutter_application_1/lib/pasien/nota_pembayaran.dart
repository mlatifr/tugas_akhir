import 'package:flutter/material.dart';
import 'package:flutter_application_1/pasien/riwayat_periksa.dart';

import '../main.dart';

class NotaPembayaranPasien extends StatefulWidget {
  const NotaPembayaranPasien({Key key}) : super(key: key);

  @override
  _NotaPembayaranPasienState createState() => _NotaPembayaranPasienState();
}

class _NotaPembayaranPasienState extends State<NotaPembayaranPasien> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Selamat datang: ' + user_aktif),
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage('assets/images/clinic.jpg'),
                // ),
                ),
          ),
          ListTile(
            title: Text('Pendaftaran Kunjungan'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            title: Text('Riwayat Pemeriksaan'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RiwayatPeriksaPasien()));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Nota Pembayaran'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(children: [
                        TableCell(child: Text('Pemeriksaan Mata')),
                        TableCell(child: Text('')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('Mata Kanan')),
                        TableCell(child: Text('')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('Mata Kiri')),
                        TableCell(child: Text('')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                      TableRow(children: [
                        TableCell(child: Text('1')),
                        TableCell(child: Text('Rp 3.500.000')),
                      ]),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
