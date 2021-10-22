import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var controllerdate = TextEditingController();

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
  // ignore: unused_field
  Timer _timerForInter; // <- Put this line on top of _MyAppState class
  @override
  void initState() {
    AVAs = [];
    _timerForInter = Timer.periodic(Duration(seconds: 5), (result) {
      setState(() {
        AdminBacaDataAntrean();
      });
    });
    super.initState();
  }

  Future<String> fetchDataAntrean() async {
    // print(controllerdate.text);
    // print('cek login function');
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
  AdminBacaDataAntrean() {
    AVAs.clear();
    Future<String> data = fetchDataAntrean();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      print('json to string: ' + json['result'].toString());
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

  Future<String> fetchDataStatusAntrean(index, String status) async {
    // print(controllerdate.text);
    // print('cek login function');
    final response =
        await http.post(Uri.parse(APIurl + "admin_status_antrean.php"), body: {
      'visit_id': AVAs[index].visit_id.toString(),
      'status': status
      // 'tgl_visit': '2021-10-21',
    });
    // print('response body adalah \n $_username \n' + response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

//
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
      // onDismissed: (direction) {
      //   // if (direction == DismissDirection.endToStart) {
      //   //   print('end to start');
      //   // } else {
      //   //   print('else');
      //   // }
      // },
      // confirmDismiss: (direction) {
      //   return showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text('Konfirmasi'),
      //           content: Text('Apakah ingin menghapus antrian ini?'),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop(true);
      //                 },
      //                 child: Text('Yes')),
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop(false);
      //                 },
      //                 child: Text('No')),
      //           ],
      //         );
      //       });
      // },
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
          print(AVAs[index].visit_id.toString());
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
                        setState(() {
                          AdminBacaDataAntrean();
                        });
                        Navigator.pop(context, 'batal antre');
                      },
                      child: Text('batal antre',
                          style: TextStyle(color: Colors.black26)),
                    ),
                    TextButton(
                      onPressed: () {
                        fetchDataStatusAntrean(index, 'belum');
                        setState(() {
                          AdminBacaDataAntrean();
                        });
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
                        setState(() {
                          AdminBacaDataAntrean();
                        });
                        Navigator.pop(context, 'Sudah');
                      },
                      child: Text('Sudah'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        leading: widgetStatusAntrean(index),
        title: Text('${AVAs[index].username}'),
        subtitle: Text('${AVAs[index].tgl_visit}'),
      ),
    );
  }

  // ignore: missing_return
  Widget widgetStatusAntrean(int index) {
    if (AVAs[index].status_antrean.toString() == 'belum') {
      return CircleAvatar(child: Icon(Icons.watch_later_outlined));
    } else if (AVAs[index].status_antrean.toString() == 'sudah') {
      return CircleAvatar(child: Icon(Icons.check));
    } else if (AVAs[index].status_antrean.toString() == 'batal') {
      return CircleAvatar(
          backgroundColor: Colors.red[100],
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
                              print(value.toString());
                              AdminBacaDataAntrean();
                            });
                          },
                          enabled: false,
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
                                  print(value.toString());
                                  AdminBacaDataAntrean();
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
