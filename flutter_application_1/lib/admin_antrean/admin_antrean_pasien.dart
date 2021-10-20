import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminVAntrean {
  var visit_id,
      vhu_id,
      pasien_id,
      tgl_visit,
      username,
      nomor_antrean,
      status_antrean,
      keluhan;
  AdminVAntrean(
      {this.visit_id,
      this.vhu_id,
      this.pasien_id,
      this.tgl_visit,
      this.username,
      this.nomor_antrean,
      this.status_antrean,
      this.keluhan});

  // untuk convert dari jSon
  factory AdminVAntrean.fromJson(Map<String, dynamic> json) {
    return new AdminVAntrean(
      visit_id: json['visit_id'],
      vhu_id: json['vhu_id'],
      pasien_id: json['pasien_id'],
      tgl_visit: json['tgl_visit'],
      username: json['username'],
      nomor_antrean: json['nomor_antrean'],
      status_antrean: json['status_antrean'],
      keluhan: json['keluhan'],
    );
  }
}

List<AdminVAntrean> AVAs = [];

class AdminAntreanPasien extends StatefulWidget {
  const AdminAntreanPasien({Key key}) : super(key: key);

  @override
  _AdminAntreanPasienState createState() => _AdminAntreanPasienState();
}

class _AdminAntreanPasienState extends State<AdminAntreanPasien> {
  @override
  void initState() {
    super.initState();
    AVAs = [];
    AdminBacaDataAntrean();
  }

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
  AdminBacaDataAntrean() {
    Future<String> data = fetchDataAntrean();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      print(json);
      for (var i in json['data']) {
        AdminVAntrean ava = AdminVAntrean.fromJson(i);
        AVAs.add(ava);
      }
      setState(() {});
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
            title: Text('Refresh'),
            onTap: () {
              setState(() {
                AdminBacaDataAntrean();
              });
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

  Widget widgetListAntrean(int index) {
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
                content: Text('Apakah ingin menghapus antrian ini?'),
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
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                'mengubah antrean pasien menjadi sudah',
                style: TextStyle(fontSize: 14),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Sudah');
                  },
                  child: Text('Sudah'),
                ),
              ],
            ),
          );
        },
        leading: CircleAvatar(),
        title: Text('${AVAs[index].username}'),
        subtitle: Text('${AVAs[index].tgl_visit}'),
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
            title: Text("Antrean Pasien"),
          ),
          drawer: widgetDrawer(),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Text('input tgl antrean'),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AVAs.length,
                    itemBuilder: (context, index) {
                      return widgetListAntrean(index);
                    }),
              ],
            ),
          )),
    );
  }
}
