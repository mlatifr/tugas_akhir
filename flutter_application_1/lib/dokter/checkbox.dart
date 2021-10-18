import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_application_1/admin_antrean/admin_antrean_pasien.dart';
// ignore: unused_import
import 'package:flutter_application_1/dokter/dr_riwayat_periksa.dart';
import '../main.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({Key key}) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
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

  // ignore: unused_field
  var _isChecked = true;
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
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
        body: new ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: values[key],
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
