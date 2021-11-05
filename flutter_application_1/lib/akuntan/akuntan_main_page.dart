import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/akuntan_v_nota_penjualan.dart';

import '../main.dart';

class AkuntanMainPage extends StatefulWidget {
  const AkuntanMainPage({Key key}) : super(key: key);

  @override
  _AkuntanMainPageState createState() => _AkuntanMainPageState();
}

class _AkuntanMainPageState extends State<AkuntanMainPage> {
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
            title: Text('Input Daftar Akun'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
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
            title: Text("List Nota"),
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
