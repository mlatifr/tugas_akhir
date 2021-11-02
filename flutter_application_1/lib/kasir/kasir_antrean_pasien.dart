import 'package:flutter/material.dart';

import '../main.dart';

class KsrAntreanPasien extends StatefulWidget {
  const KsrAntreanPasien({Key key}) : super(key: key);

  @override
  _KsrAntreanPasienState createState() => _KsrAntreanPasienState();
}

Widget widgetDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Selamat datang: \n' + username,
            style: TextStyle(
              backgroundColor: Colors.white.withOpacity(0.85),
              fontSize: 20,
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('./asset/image/clinic_text.jpg'),
            ),
          ),
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

class _KsrAntreanPasienState extends State<KsrAntreanPasien> {
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
          body: Column(
            children: [
              // widgetSelectTgl(),
              // widgetLsTile(),
            ],
          )),
    );
  }
}
