import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class PsienVNoAntr {
  var id_user, no_antre, tgl_visit;
  PsienVNoAntr({this.id_user, this.no_antre, this.tgl_visit});

  // untuk convert dari jSon
  factory PsienVNoAntr.fromJson(Map<String, dynamic> json) {
    return new PsienVNoAntr(
      id_user: json['id_user'],
      no_antre: json['no_antre'],
      tgl_visit: json['tgl_visit'],
    );
  }
}

List<PsienVNoAntr> PVAs = [];

// ignore: must_be_immutable
class AntreanPasien extends StatefulWidget {
  var user_klinik_id, tgl_visit, antrean_sekarang;
  AntreanPasien(
      {Key key, this.user_klinik_id, this.tgl_visit, this.antrean_sekarang})
      : super(key: key);

  @override
  _AntreanPasienState createState() => _AntreanPasienState();
}

class _AntreanPasienState extends State<AntreanPasien> {
  Future<String> fetchDataTglVstPsien() async {
    var response = await http
        .post(Uri.parse(APIurl + "pasien_view_antrean_user_tgl.php"), body: {
      'user_klinik_id': widget.user_klinik_id.toString(),
      'tgl_visit': widget.tgl_visit.toString()
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaDataTglVstPsien() {
    Future<String> data = fetchDataTglVstPsien();
    data.then((value) {
      // ignore: unused_local_variable
      setState(() {
        Map json = jsonDecode(value);
        if (json['result'].toString() == 'success') {
          for (var i in json['data']) {
            PsienVNoAntr pva = PsienVNoAntr.fromJson(i);
            PVAs.add(pva);
          }
        } else {}
        setState(() {
          // print('jumhlas data antre: ');
          // print('jumhlas data antre: ' + PVAs.length.toString());
        });
      });
    });
  }

  @override
  void initState() {
    PVAs.clear();
    bacaDataTglVstPsien();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Antrean'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: fetchDataTglVstPsien(),
            builder: (context, snapshot) {
              print(PVAs.length);
              if (snapshot.hasData) {
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: PVAs.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          children: [
                            Text(
                              "nomor antrean anda:",
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              PVAs[index].no_antre.toString(),
                              style: TextStyle(
                                  fontSize: 88, color: Colors.blueAccent),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Tanggal Visit:',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              PVAs[index].tgl_visit.toString(),
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'antrean saat ini:',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.antrean_sekarang.toString(),
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 50),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              thickness: 8,
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
