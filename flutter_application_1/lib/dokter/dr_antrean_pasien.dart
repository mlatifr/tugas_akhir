import 'package:flutter/material.dart';
import 'package:flutter_application_1/dokter/dr_riwayat_periksa.dart';
import '../main.dart';

class DrAntreanPasien extends StatefulWidget {
  const DrAntreanPasien({Key key}) : super(key: key);

  @override
  _DrAntreanPasienState createState() => _DrAntreanPasienState();
}

class _DrAntreanPasienState extends State<DrAntreanPasien> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Selamat datang: ' + username),
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage('assets/images/clinic.jpg'),
                // ),
                ),
          ),
          ListTile(
            title: Text('Cari Pasien'),
            onTap: () {
              Navigator.of(context).pop();
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

  Widget lsTile(int index) {
    if (index <= 4) {
      return ListTile(
        leading: CircleAvatar(),
        title: Text('Pasien ${index + 1}'),
        subtitle: Text('sub judul'),
        trailing: Icon(Icons.check_box),
      );
    } else {
      return ListTile(
        leading: CircleAvatar(),
        title: Text('Pasien ${index + 1}'),
        subtitle: Text('sub judul'),
        trailing: Icon(Icons.access_time),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Antrean Pasien"),
          ),
          drawer: widgetDrawer(),
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrRiwayatPeriksaPasien(
                                  namaPasien: '${index + 1}',
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: lsTile(index),
                    //  ListTile(
                    //   leading: CircleAvatar(),
                    //   title: Text('Pasien ${index + 1}'),
                    //   subtitle: Text('sub judul'),
                    //   trailing: Icon(Icons.check_box),
                    // ),
                  ),
                );
              })),
    );
  }
}
