import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'admin_input_tindakan.dart';

var controllerdate = TextEditingController();
var controllerAntreanSekarang = TextEditingController();
var controllerBatasAntrean = TextEditingController();
var controllerAntreanTerakhir = TextEditingController();

class AdminVAntrean {
  // ignore: non_constant_identifier_names
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
var antreanSekarang, batasAntrean, antreanTerakhir;

class AdminAntreanPasien extends StatefulWidget {
  const AdminAntreanPasien({Key key}) : super(key: key);

  @override
  _AdminAntreanPasienState createState() => _AdminAntreanPasienState();
}

class _AdminAntreanPasienState extends State<AdminAntreanPasien> {
  // ignore: unused_field
  Timer _timerForInter; // <- Put this line on top of _MyAppState class
  void functionTimerRefresh() {
    print('timer start');
    var i = 0;
    _timerForInter = Timer.periodic(Duration(seconds: 15), (result) {
      i += i;
      setState(() {
        print('timer admin antrean: ' + i.toString());
        AdminBacaDataAntrean();
      });
    });
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print(date);
    controllerdate.text = date.toString().substring(0, 10);
    AdminBacaDataAntrean();
    AdminBacaDataAntreanSekarangAwal();
    AVAs = [];
    functionTimerRefresh();
    super.initState();
  }

  Future<String> fetchDataResetAntreanTerakhir() async {
    final response =
        await http.post(Uri.parse(APIurl + "admin_upd_antrean_now.php"), body: {
      'antrean_terakhir': '0',
      // 'tgl_visit': '2021-10-21',
    });
    if (response.statusCode == 200) {
      print('fetchDataResetAntreanTerakhir: ' + response.body.toString());
      AdminBacaDataAntreanSekarangAwal();
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  Future<String> fetchDataAntreanSekarangAwal() async {
    final response =
        await http.post(Uri.parse(APIurl + "pasien_view_antrean_sekarang.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  // ignore: non_constant_identifier_names
  AdminBacaDataAntreanSekarangAwal() {
    AVAs.clear();
    Future<String> data = fetchDataAntreanSekarangAwal();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      setState(() {
        antreanSekarang = json['antrean_sekarang'].toString();
        batasAntrean = json['batas_antrean'].toString();
        antreanTerakhir = json['antrean_terakhir'].toString();
        widgetInfoBar();
      });
    });
  }

  Future<String> fetchDataAntrean() async {
    final response =
        await http.post(Uri.parse(APIurl + "admin_v_antrean.php"), body: {
      'tgl_visit': controllerdate.text.toString().substring(0, 10),
      // 'tgl_visit': '2021-10-21',
    });
    // print('response body adalah \n $_username \n' + response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

// tahap 2 API 1
  // ignore: non_constant_identifier_names
  AdminBacaDataAntrean() {
    AVAs.clear();
    Future<String> data = fetchDataAntrean();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      // print('json to string: ' + json['result'].toString());
      if (json['result'].toString() == 'success') {
        for (var i in json['data']) {
          AdminVAntrean ava = AdminVAntrean.fromJson(i);
          AVAs.add(ava);
        }
      } else {}
      setState(() {
        widgetLbuilderCekAntrean();
      });
    });
  }

  Future<String> fetchDataAntreanSekarang() async {
    final response =
        await http.post(Uri.parse(APIurl + "admin_upd_antrean_now.php"), body: {
      'antrean_sekarang': controllerAntreanSekarang.text.toString(),
      'batas_antrean': controllerBatasAntrean.text.toString(),
      // 'tgl_visit': '2021-10-21',
    });
    // print('response body adalah \n $_username \n' + response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  // tahap 2 API 1
  // ignore: non_constant_identifier_names
  AdminBacaDataAntreanSekarang() {
    AVAs.clear();
    Future<String> data = fetchDataAntreanSekarang();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      // print('json to string: ' + json['result'].toString());
      if (json['result'].toString() == 'success') {
        antreanSekarang = json['antrean_sekarang'].toString();
        batasAntrean = json['batas_antrean'].toString();
        antreanTerakhir = json['antrean_terakhir'].toString();
      } else {}
      setState(() {
        widgetLbuilderCekAntrean();
      });
    });
  }

  // ignore: non_constant_identifier_names
  AdminKlikBacaDataAntrean() {
    AVAs.clear();
    setState(() {
      widgetLbuilderCekAntrean();
    });
    Future<String> data = fetchDataAntrean();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      // print('json to string: ' + json['result'].toString());
      if (json['result'].toString() == 'success') {
        for (var i in json['data']) {
          AdminVAntrean ava = AdminVAntrean.fromJson(i);
          AVAs.add(ava);
        }
      } else {}
      setState(() {});
    });
  }

  Future<String> fetchDataStatusAntrean(index, String status) async {
    final response = await http.post(
        Uri.parse(APIurl + "admin_status_antrean.php"),
        body: {'visit_id': AVAs[index].visit_id.toString(), 'status': status});
    if (response.statusCode == 200) {
      AdminKlikBacaDataAntrean();
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  onGoBack(dynamic value) {
    functionTimerRefresh();
    print('timer start');
    setState(() {
      AVAs = [];
    });
  }

//
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
            title: Text('Input Tindakan'),
            onTap: () {
              _timerForInter.cancel();
              print('timer cancel');
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminInputTindakan()))
                  .then((onGoBack));
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

  Widget widgetListAntrean(int index) {
    return Dismissible(
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
          // print(AVAs[index].visit_id.toString());
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                'mengubah status antrean pasien:',
                style: TextStyle(fontSize: 14),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        fetchDataStatusAntrean(index, 'batal');
                        Navigator.pop(context, 'batal antre');
                      },
                      child: Text('batal antre',
                          style: TextStyle(color: Colors.black26)),
                    ),
                    TextButton(
                      onPressed: () {
                        fetchDataStatusAntrean(index, 'belum');
                        Navigator.pop(context, 'belum');
                      },
                      child: Text(
                        'belum',
                        style: TextStyle(color: Colors.black26),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        fetchDataStatusAntrean(index, 'sudah');
                        Navigator.pop(context, 'sudah');
                      },
                      child: Text('Sudah'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        leading: CircleAvatar(
          child: Text("${index + 1}"),
        ),
        title: Text('${AVAs[index].username}'),
        subtitle: Text('${AVAs[index].tgl_visit}'),
        trailing: widgetStatusAntrean(index),
      ),
    );
  }

  // ignore: missing_return
  Widget widgetStatusAntrean(int index) {
    if (AVAs[index].status_antrean.toString() == 'belum') {
      return CircleAvatar(radius: 15, child: Icon(Icons.watch_later_outlined));
    } else if (AVAs[index].status_antrean.toString() == 'sudah') {
      return CircleAvatar(radius: 15, child: Icon(Icons.check));
    } else if (AVAs[index].status_antrean.toString() == 'batal') {
      return CircleAvatar(
          radius: 15,
          backgroundColor: Colors.red[400],
          child: Icon(
            Icons.cancel,
            color: Colors.white,
          ));
    }
  }

  Widget widgetLbuilderCekAntrean() {
    if (AVAs.length > 0) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: AVAs.length,
          itemBuilder: (context, index) {
            return widgetListAntrean(index);
          });
    } else {
      return Text('data tidak ditemukan');
    }
  }

  Widget widgetInfoBar() {
    return Row(
      children: [
        Expanded(
            child: Text(
          "antrean sekarang: \n",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Text(
          antreanSekarang.toString(),
          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Text(
          "batas antrean : \n",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Text(
          batasAntrean.toString(),
          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Text(
          "antrean terakhir : \n",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Text(
          antreanTerakhir.toString(),
          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
          textAlign: TextAlign.center,
        )),
      ],
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
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Akan mengatur \nAntrean sekarang:0 \nBatas antrean:0 \nAntrean terakhir:0',
                                  style: TextStyle(fontSize: 14),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'batal');
                                        },
                                        child: Text(
                                          'batal',
                                          // style: TextStyle(
                                          //     color: Colors.black26)
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          fetchDataResetAntreanTerakhir();
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: Text(
                                          'ok',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                    },
                    child: Row(
                      children: [
                        Text('Reset Antrean terkhir'),
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ],
                    )),
                widgetInfoBar(),
                Divider(
                  color: Colors.blue,
                  thickness: 2,
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 5,
                            child: TextField(
                              controller: controllerAntreanSekarang,
                              onChanged: (value) {
                                setState(() {
                                  controllerAntreanSekarang.text = value;
                                  controllerAntreanSekarang.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: controllerAntreanSekarang
                                              .text.length));
                                  print(value.toString());
                                });
                              },
                              enabled: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: 'Antrean Sekarang',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: controllerBatasAntrean,
                              onChanged: (value) {
                                setState(() {
                                  controllerBatasAntrean.text = value;
                                  controllerBatasAntrean.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: controllerBatasAntrean
                                              .text.length));
                                  // print(value.toString());
                                });
                              },
                              enabled: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: 'Batas Antrean',
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: SizedBox()),
                        ElevatedButton(
                            onPressed: () {
                              AdminBacaDataAntreanSekarangAwal();
                              AdminBacaDataAntreanSekarang();
                              AdminBacaDataAntrean();
                            },
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24.0,
                            ))
                      ],
                    )),
                Padding(
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
                              controllerdate.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: controllerdate.text.length));
                              // print(value.toString());
                              AdminBacaDataAntrean();
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
                                  controllerdate.text =
                                      value.toString().substring(0, 10);
                                  // print(value.toString());
                                  AdminBacaDataAntrean();
                                  AdminBacaDataAntreanSekarangAwal();
                                  // print('elevatedButton');
                                });
                              });
                            },
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.white,
                              size: 24.0,
                            ))
                      ],
                    )),
                widgetLbuilderCekAntrean()
              ],
            ),
          )),
    );
  }
}
