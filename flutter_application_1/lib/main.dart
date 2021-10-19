import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_antrean/admin_antrean_pasien.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/pasien/nomor_antrean_pasien.dart';
import 'package:flutter_application_1/pasien/nota_pembayaran.dart';
import 'package:flutter_application_1/pasien/riwayat_periksa.dart';
import 'package:flutter_application_1/pasien/pendaftaran_pasien_baru.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'apoteker/apt_antrean_resep.dart';
import 'dokter/dr_antrean_pasien.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: non_constant_identifier_names
String username, userid = "";
var keluhan = TextEditingController();
// ignore: non_constant_identifier_names
String status_antrean, navigateToNomorAntrean;
int antrean_sekarang, antrean_terakhir, batas_antrean;
String APIurl = "https://192.168.1.8/tugas_akhir/";

//untuk memasukan keluhan + nomor antrean: pasien_input_keluhan.php
Future<String> fetchDataKeluhan() async {
  final response =
      await http.post(Uri.parse(APIurl + "pasien_input_keluhan.php"), body: {
    'keluhan': keluhan.text,
    'no_antrean': (antrean_sekarang + 1).toString(),
    'user_klinik_id': userid.toString()
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

bacaDataKeluhan() {
  Future<String> data = fetchDataKeluhan();
  data.then((value) {
    // ignore: unused_local_variable
    Map json = jsonDecode(value);
    if (json['result'] == 'success') {
      navigateToNomorAntrean = 'success';
    } else {
      print(json);
    }
    print(json);
  });
}

// untuk mengecek antrean
Future<String> fetchDataAntreanSekarang() async {
  final response =
      await http.post(Uri.parse(APIurl + "pasien_view_antrean_sekarang.php"));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

bacaDataAntrean() {
  Future<String> data = fetchDataAntreanSekarang();
  data.then((value) {
    // ignore: unused_local_variable
    Map json = jsonDecode(value);
    status_antrean = json['status_antrean'];
    antrean_sekarang = json['antrean_sekarang'];
    antrean_terakhir = json['antrean_terakhir'];
    batas_antrean = json['batas_antrean'];
    //     print('''json: $json
    // status_antrean: $status_antrean
    // antrean_sekarang: $antrean_sekarang
    // antrean_terakhir: $antrean_terakhir
    // batas_antrean: $batas_antrean''');
  });
}

void getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  userid = prefs.getString("userid");
  print('user id main: $userid');
}

void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("_username");
  prefs.remove("userid");
  main();
}

// ignore: missing_return
Future<String> cekLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    String _username = prefs.getString("_username") ?? '';
    // print('cek _username = $_username');
    return _username;
  } catch (e) {
    print('error karena $e');
  }
}

// untuk allow certificates login
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // runApp(MyApp());
  HttpOverrides.global =
      new MyHttpOverrides(); // untuk allow certificates login
  WidgetsFlutterBinding.ensureInitialized();

  cekLogin().then((String result) {
    if (result == 'daftarBaru') {
      username = result;
      runApp(MaterialApp(
        home: DaftarPasienBaru(),
        debugShowCheckedModeBanner: false,
      ));
    } else if (result == '' && result != 'daftarBaru') {
      username = result;
      runApp(MaterialApp(home: LoginPage()));
    } else if (result.contains('admin')) {
      username = result;
      runApp(MaterialApp(home: AdminAntreanPasien()));
    } else if (result.contains('dokter')) {
      username = result;
      runApp(MaterialApp(home: DrAntreanPasien()));
    } else if (result.contains('apoteker')) {
      username = result;
      runApp(MaterialApp(home: AptAntreanPasien()));
    } else {
      username = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pendaftaran'),
      // home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            title: Text('Nomor Antrean'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AntreanPasien()));
            },
          ),
          ListTile(
            title: Text('Nota Pembayaran'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotaPembayaranPasien()));
            },
          ),
          ListTile(
            title: Text('Riwayat Pemeriksaan'),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RiwayatPeriksaPasien()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: widgetDrawer(),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Image.asset('./asset/image/clinic.jpg')),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text('Selamat Datang'),
              Text(username),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                  maxLines: 8,
                  controller: keluhan,
                  decoration: InputDecoration(
                    labelText: "ketik keluhan disini",
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
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      print('userid: $userid');
                      getUserId();
                      bacaDataAntrean();
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Anda akan mendaftar dengan keluhan:',
                            style: TextStyle(fontSize: 14),
                          ),
                          content: TextFormField(
                              maxLines: 5,
                              controller: keluhan,
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
                                bacaDataKeluhan();
                                Navigator.pop(context);
                                keluhan.clear();
                                // Navigator.pop(context, 'OK');
                                if (navigateToNomorAntrean == 'success') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AntreanPasien()));
                                }
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'SIMPAN',
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
