import 'package:flutter/material.dart';

import '../main.dart';

class AkuntanVNotaPjln extends StatefulWidget {
  const AkuntanVNotaPjln({Key key}) : super(key: key);

  @override
  _AkuntanVNotaPjlnState createState() => _AkuntanVNotaPjlnState();
}

class _AkuntanVNotaPjlnState extends State<AkuntanVNotaPjln> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n ' + username,
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
            title: Text('Input Penjurnalan'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // _timerForInter.cancel();
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
            title: Text("Daftar Akun"),
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
