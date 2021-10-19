import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdminAntreanPasien extends StatefulWidget {
  const AdminAntreanPasien({Key key}) : super(key: key);

  @override
  _AdminAntreanPasienState createState() => _AdminAntreanPasienState();
}

class _AdminAntreanPasienState extends State<AdminAntreanPasien> {
  Future<String> fetchDataAntrean() async {
    // print('cek login function');
    final response =
        await http.post(Uri.parse(APIurl + "admin_v_antrean.php"), body: {
      'tgl_visit': '2021-10',
    });
    // print('response body adalah \n $_username \n' + response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

// tahap 2 API 1
  bacaDataAntrean() {
    Future<String> data = fetchDataAntrean();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      print(json);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    bacaDataAntrean();
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
                return Dismissible(
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      print('end to start');
                    } else {
                      print('else');
                    }
                  },
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Konfirmasi'),
                            content:
                                Text('Apakah ingin menghapus antrian ini?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No')),
                            ],
                          );
                        });
                  },
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 25,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('${index + 1}'),
                    subtitle: Text('sub judul'),
                  ),
                );
              })),
    );
  }
}
