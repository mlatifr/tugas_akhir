import 'dart:convert';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/akuntan_fetch_penjualanObat.dart';
import 'package:flutter_application_1/akuntan/akuntan_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/akuntan_main_page.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AkuntanVNotaPjln extends StatefulWidget {
  const AkuntanVNotaPjln({Key key}) : super(key: key);

  @override
  _AkuntanVNotaPjlnState createState() => _AkuntanVNotaPjlnState();
}

class _AkuntanVNotaPjlnState extends State<AkuntanVNotaPjln> {
  var numberFormatRp = new NumberFormat("#,##0", "id_ID");

// ignore: non_constant_identifier_names
  AkunanBacaDataPenjualanObat(tgl) {
    ListPenjualanObat.clear();
    Future<String> data = fetchDataVPenjualanObat(tgl);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print(i);
        AkuntanVPenjualanObat pjlnObtNota = AkuntanVPenjualanObat.fromJson(i);
        ListPenjualanObat.add(pjlnObtNota);
      }
      setState(() {
        widgetLsPjlnObat();
        widgetTextTotalPenjualanObat();
      });
    });
  }

  Widget widgetLsPjlnObat() {
    if (ListPenjualanObat.length > 0) {
      return ExpansionTile(title: Text('Daftar Penjualan Obat'), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ListPenjualanObat.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text('${ListPenjualanObat[index].nama}'),
                      subtitle: Text(
                          '${ListPenjualanObat[index].tgl_resep.substring(0, 10)}\n${ListPenjualanObat[index].jumlah} x ${numberFormatRp.format(int.parse(ListPenjualanObat[index].harga))} |  Total:Rp ${numberFormatRp.format(ListPenjualanObat[index].total_harga)}'),
                    ),
                  ));
            }),
      ]);
    } else {
      return Column(
        children: [
          CircularProgressIndicator(),
          Text('data tidak ditemukan'),
        ],
      );
    }
  }

  Widget widgetTextTotalPenjualanObat() {
    int total = 0;
    if (ListPenjualanObat.length > 0) {
      print('ListPenjualanObat.length: ${ListPenjualanObat.length}');
      for (var i = 0; i < ListPenjualanObat.length; i++) {
        total += ListPenjualanObat[i].total_harga;
      }
      print(total.toString());
      return ListTile(
          title:
              Text('Total Penjualan Obat Rp ${numberFormatRp.format(total)}'));
    }
  }

  var controllerdate = TextEditingController();
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
                  print('TextFormField controllerdate $value');
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Bulan Transaksi',
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
                  showMonthPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2200))
                      .then((value) {
                    setState(() {
                      controllerdate.text = value.toString().substring(0, 7);
                      AkunanBacaDataPenjualanObat(controllerdate.text);
                      print('showDatePicker : ${controllerdate.text}');
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
            title: Text("Nota Penjualan"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            children: [
              widgetSelectTgl(),
              widgetLsPjlnObat(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: widgetTextTotalPenjualanObat()),
              ),
            ],
          )),
    );
  }
}
