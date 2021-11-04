import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/kasir/kasir_detail_pasien.dart';

import '../main.dart';
import 'kasir_get_antrean.dart';
import 'kasir_get_tindakan.dart';

class KsrAntreanPasien extends StatefulWidget {
  const KsrAntreanPasien({Key key}) : super(key: key);

  @override
  _KsrAntreanPasienState createState() => _KsrAntreanPasienState();
}

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
          title: Text('Logout'),
          onTap: () {
            doLogout();
          },
        ),
      ],
    ),
  );
}

var controllerdate = TextEditingController();

class _KsrAntreanPasienState extends State<KsrAntreanPasien> {
  // ignore: non_constant_identifier_names
  KasirBacaDataVAntrean(pDate) {
    KVAs.clear();
    Future<String> data = fetchDataKasirVAntreanPasien(pDate);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        KasirVAntrean kva = KasirVAntrean.fromJson(i);
        KVAs.add(kva);
      }
      setState(() {});
    });
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
                      KasirBacaDataVAntrean(controllerdate.text);
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

// ignore: unused_field
  Timer _timerForInter; // <- Put this line on top of _MyAppState class
  void functionTimerRefresh() {
    _timerForInter = Timer.periodic(Duration(seconds: 15), (result) {
      setState(() {
        KasirBacaDataVAntrean(controllerdate.text);
      });
    });
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print(date);
    controllerdate.text = date.toString().substring(0, 10);
    KasirBacaDataVAntrean(controllerdate.text);
    KVAs = [];
    functionTimerRefresh();
    super.initState();
  }

  onGoBack(dynamic value) {
    functionTimerRefresh();
    print('timer start');
    setState(() {
      KasirBacaDataVAntrean(controllerdate.text);
      widgetLsTile();
    });
  }

  Widget widgetLsTile() {
    if (KVAs.length > 0) {
      return Expanded(
        child: ListView.builder(
            itemCount: KVAs.length,
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
                              builder: (context) => KasirDetailPasien(
                                  namaPasien: KVAs[index].userName,
                                  visitId: KVAs[index].visitId,
                                  visitDate: controllerdate.text
                                      .toString()
                                      .substring(0, 10)))).then((onGoBack));
                    },
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('${KVAs[index].userName}'),
                    subtitle: Text('sub judul'),
                    // trailing: widgetStatusAntrean(index)
                  ));
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
