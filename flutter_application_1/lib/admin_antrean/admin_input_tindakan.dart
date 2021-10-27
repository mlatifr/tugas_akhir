import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class AdminInputTindakan extends StatefulWidget {
  const AdminInputTindakan({Key key}) : super(key: key);

  @override
  _AdminInputTindakanState createState() => _AdminInputTindakanState();
}

class AdminVListTindakan {
  var idTindakan, namaTindakan, hargaTindakan;
  AdminVListTindakan({
    this.idTindakan,
    this.namaTindakan,
    this.hargaTindakan,
  });

  // untuk convert dari jSon
  factory AdminVListTindakan.fromJson(Map<String, dynamic> json) {
    return new AdminVListTindakan(
      idTindakan: json['id'],
      namaTindakan: json['nama'],
      hargaTindakan: json['harga'],
    );
  }
}

class _AdminInputTindakanState extends State<AdminInputTindakan> {
  @override
  void initState() {
    AdminBacaDataListTindakan();
    super.initState();
  }

  Future<String> fetchDataAdminInputTindakan() async {
    final response =
        await http.post(Uri.parse(APIurl + "admin_input_tindakan.php"), body: {
      'nama': '300',
      'harga': '300',
    });
    if (response.statusCode == 200) {
      print("respon input tindakan: ${response.body}");
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  // ignore: non_constant_identifier_names
  List<AdminVListTindakan> AVTs = [];
  // ignore: non_constant_identifier_names
  AdminBacaDataInputTindakan() {
    Future<String> data = fetchDataAdminInputTindakan();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      if (json['result'].toString() == 'success') {
        print('input succes');
        AdminBacaDataListTindakan();
      }
      setState(() {});
    });
  }

  Future<String> fetchDataAdminListTindakan() async {
    final response =
        await http.post(Uri.parse(APIurl + "dokter_v_list_tindakan.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  // ignore: non_constant_identifier_names
  AdminBacaDataListTindakan() {
    AVTs.clear();
    Future<String> data = fetchDataAdminListTindakan();
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        AdminVListTindakan dva = AdminVListTindakan.fromJson(i);
        AVTs.add(dva);
      }
      setState(() {});
    });
  }

  Widget widgetInputTindakan() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.27),
        TextFormField(
            maxLines: 1,
            // controller: keluhan,
            decoration: InputDecoration(
              labelText: "Nama Tindakan",
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        TextFormField(
            maxLines: 1,
            // controller: keluhan,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Harga Tindakan",
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Anda akan menginputkan tindakan:',
                        style: TextStyle(fontSize: 14),
                      ),
                      content: TextFormField(
                          enabled: false,
                          maxLines: 5,
                          // controller: keluhan,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          )),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            AdminBacaDataInputTindakan();
                            Navigator.pop(context, 'ok');
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Text(
                'SIMPAN',
              )),
        ),
      ],
    );
  }

  Widget widgetListTindakan() {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: AVTs.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                '${index + 1} ${AVTs[index].namaTindakan}',
                style: TextStyle(fontSize: 20),
              ),
              Divider(),
            ],
          );
        });
  }

  Widget widgetTabView() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 150.0),
            child: Material(
              color: Colors.blue,
              child: TabBar(
                // onTap: AdminBacaDataListTindakan(),
                unselectedLabelColor: Colors.lightBlue[200],
                labelColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.medical_services,
                    ),
                    text: 'daftar tindakan',
                    iconMargin: EdgeInsets.only(bottom: 10.0),
                  ),
                  Tab(
                    icon: Icon(Icons.add_circle),
                    text: 'tambah',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                widgetListTindakan(),
                widgetInputTindakan(),
              ],
            ),
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
          title: Text('Input Tindakan'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: widgetTabView(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            AdminBacaDataListTindakan();
          },
          icon: Icon(Icons.refresh),
          label: Text(
            "refresh",
            style: TextStyle(fontSize: 10),
          ),
          backgroundColor: Colors.blue.withOpacity(0.65),
        ),
      ),
    );
  }
}
