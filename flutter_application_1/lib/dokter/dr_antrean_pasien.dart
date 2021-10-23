import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/dokter/dr_riwayat_periksa.dart';
import '../main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DrAntreanPasien extends StatefulWidget {
  const DrAntreanPasien({Key key}) : super(key: key);

  @override
  _DrAntreanPasienState createState() => _DrAntreanPasienState();
}

class DokterVAntrean {
  var visit_id,
      vhu_id,
      pasien_id,
      tgl_visit,
      username,
      nomor_antrean,
      status_antrean,
      keluhan;
  DokterVAntrean(
      {this.visit_id,
      this.vhu_id,
      this.pasien_id,
      this.tgl_visit,
      this.username,
      this.nomor_antrean,
      this.status_antrean,
      this.keluhan});

  // untuk convert dari jSon
  factory DokterVAntrean.fromJson(Map<String, dynamic> json) {
    return new DokterVAntrean(
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

var controllerdate = TextEditingController();
List<DokterVAntrean> DVAs = [];

class _DrAntreanPasienState extends State<DrAntreanPasien> {
  Future<String> fetchDataDokterAntreanPasien() async {
    final response =
        await http.post(Uri.parse(APIurl + "dokter_v_antrean.php"), body: {
      'tgl_visit': controllerdate.text.toString().substring(0, 10),
      // 'tgl_visit': '2021-10-21',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  DokterBacaDataAntrean() {
    DVAs.clear();
    Future<String> data = fetchDataDokterAntreanPasien();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      setState(() {
        // antreanSekarang = json['antrean_sekarang'].toString();
        // batasAntrean = json['batas_antrean'].toString();
      });
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrRiwayatPeriksaPasien(
                        namaPasien: '${index + 1}',
                      )));
        },
        leading: CircleAvatar(),
        title: Text('Pasien ${index + 1}'),
        subtitle: Text('sub judul'),
        trailing: Icon(Icons.check_box),
      );
    } else {
      return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DrRiwayatPeriksaPasien(
                        namaPasien: '${index + 1}',
                      )));
        },
        leading: CircleAvatar(),
        title: Text('Pasien ${index + 1}'),
        subtitle: Text('sub judul'),
        trailing: Icon(Icons.access_time),
      );
    }
  }

  Widget widgetSelectTgl() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
              controller: controllerdate,
              onChanged: (value) {
                setState(() {
                  controllerdate.text = value.toString();
                  controllerdate.selection = TextSelection.fromPosition(
                      TextPosition(offset: controllerdate.text.length));
                  print(value.toString());
                  // AdminBacaDataAntrean();
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Tanggal Visit',
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 10);
                      print(value.toString());
                      // AdminBacaDataAntrean();
                    });
                  });
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.white,
                  size: 24.0,
                ))
          ],
        ));
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
          body: Column(
            children: [
              widgetSelectTgl(),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: lsTile(index),
                        //  ListTile(
                        //   leading: CircleAvatar(),
                        //   title: Text('Pasien ${index + 1}'),
                        //   subtitle: Text('sub judul'),
                        //   trailing: Icon(Icons.check_box),
                        // ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
