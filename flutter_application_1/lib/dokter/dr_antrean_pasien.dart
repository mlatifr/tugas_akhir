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
  var visitId,
      vhuId,
      pasienId,
      tglVisit,
      userName,
      nomorAntrean,
      statusAntrean,
      keluhan;
  DokterVAntrean(
      {this.visitId,
      this.vhuId,
      this.pasienId,
      this.tglVisit,
      this.userName,
      this.nomorAntrean,
      this.statusAntrean,
      this.keluhan});

  // untuk convert dari jSon
  factory DokterVAntrean.fromJson(Map<String, dynamic> json) {
    return new DokterVAntrean(
      visitId: json['visit_id'],
      vhuId: json['vhu_id'],
      pasienId: json['pasien_id'],
      tglVisit: json['tgl_visit'],
      userName: json['username'],
      nomorAntrean: json['nomor_antrean'],
      statusAntrean: json['status_antrean'],
      keluhan: json['keluhan'],
    );
  }
}

var controllerdate = TextEditingController();
// ignore: non_constant_identifier_names
List<DokterVAntrean> DVAs = [];

class _DrAntreanPasienState extends State<DrAntreanPasien> {
  // ignore: unused_field
  Timer _timerForInter; // <- Put this line on top of _MyAppState class
  void functionTimerRefresh() {
    _timerForInter = Timer.periodic(Duration(seconds: 15), (result) {
      setState(() {
        DokterBacaDataAntrean();
      });
    });
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print(date);
    controllerdate.text = date.toString().substring(0, 10);
    DokterBacaDataAntrean();
    DVAs = [];
    functionTimerRefresh();
    super.initState();
  }

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

  // ignore: non_constant_identifier_names
  DokterBacaDataAntrean() {
    DVAs.clear();
    Future<String> data = fetchDataDokterAntreanPasien();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        DokterVAntrean dva = DokterVAntrean.fromJson(i);
        DVAs.add(dva);
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
            title: Text('Cari Pasien'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              _timerForInter.cancel();
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  onGoBack(dynamic value) {
    functionTimerRefresh();
    print('timer start');
    setState(() {
      DokterBacaDataAntrean();
      widgetLsTile();
    });
  }

  Widget widgetStatusAntrean(int index) {
    if (DVAs[index].statusAntrean.toString() == 'belum') {
      return CircleAvatar(radius: 15, child: Icon(Icons.watch_later_outlined));
    } else if (DVAs[index].statusAntrean.toString() == 'sudah') {
      return CircleAvatar(radius: 15, child: Icon(Icons.check));
    } else if (DVAs[index].statusAntrean.toString() == 'batal') {
      return CircleAvatar(
          radius: 15,
          backgroundColor: Colors.red[400],
          child: Icon(
            Icons.cancel,
            color: Colors.white,
          ));
    }
  }

  Widget widgetLsTile() {
    if (DVAs.length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: DVAs.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                      onTap: () {
                        _timerForInter.cancel();
                        print('timer stop');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrRiwayatPeriksaPasien(
                                      namaPasien: '${DVAs[index].userName}',
                                    ))).then((onGoBack));
                      },
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text('${DVAs[index].userName}'),
                      subtitle: Text('sub judul'),
                      trailing: widgetStatusAntrean(index)));
            }),
      );
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
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
                      DokterBacaDataAntrean();
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
              widgetLsTile(),
            ],
          )),
    );
  }
}
