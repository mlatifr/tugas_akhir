import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_antrean/admin_antrean_pasien.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/pasien/nomor_antrean_pasien.dart';
import 'package:flutter_application_1/pasien/nota_pembayaran.dart';
import 'package:flutter_application_1/pasien/riwayat_periksa.dart';
import 'package:flutter_application_1/pendaftaran_pasien_baru.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String user_aktif = "";
// ignore: non_constant_identifier_names
String APIurl, keluhan;
void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  main();
}

// ignore: missing_return
Future<String> cekLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    String user_id = prefs.getString("user_id") ?? '';
    print('cek user_id = $user_id');
    return user_id;
  } catch (e) {
    print('error karena $e');
  }
}

void main() {
  // runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  cekLogin().then((String result) {
    if (result == 'daftarBaru') {
      user_aktif = result;
      runApp(MaterialApp(
        home: DaftarPasienBaru(),
        debugShowCheckedModeBanner: false,
      ));
    } else if (result == '' && result != 'daftarBaru') {
      user_aktif = result;
      runApp(MaterialApp(home: LoginPage()));
    } else if (result == 'admin') {
      user_aktif = result;
      runApp(MaterialApp(home: AdminAntreanPasien()));
    } else {
      user_aktif = result;
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
            child: Text('Selamat datang: ' + user_aktif),
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
              Text(user_aktif),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              TextFormField(
                  maxLines: 8,
                  onChanged: (value) {
                    keluhan = value;
                  },
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
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Anda akan mendaftar dengan keluhan:',
                            style: TextStyle(fontSize: 14),
                          ),
                          content: TextFormField(
                              maxLines: 5,
                              initialValue: keluhan,
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
                              onPressed: () => Navigator.pop(context, 'OK'),
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
