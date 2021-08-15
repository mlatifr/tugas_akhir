// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String user_aktif = "";
String APIurl, keluhan;
void doLogout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("user_id");
  main();
}

Future<String> cekLogin() async {
  try {
    final prefs = await SharedPreferences.getInstance();
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
    if (result == '') {
      print('result = $result');
      runApp(LoginPage());
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pendaftaran'),
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
            title: Text('none'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => actorList()));
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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
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
                    labelText: "Keluhan",
                    fillColor: Colors.white,
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
                      doLogin();
                      // print(_username);
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
