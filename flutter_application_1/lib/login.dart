import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: unused_element
String _username, _password, _userid;
Future<String> fetchData() async {
  // print('cek login function');
  final response = await http.post(Uri.parse(APIurl + "login.php"), body: {
    'id': _username,
    'sandi': _password,
    // 'id': 'pasien1',
    // 'sandi': 'pasien1',
  });
  // print('response body adalah \n $_username \n' + response.body);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

// tahap 2 API 1
bacaData() {
  Future<String> data = fetchData();
  data.then((value) {
    //Mengubah json menjadi Array
    Map json = jsonDecode(value);
    // print('json id nya adalah =' + json['id'].toString());
    _userid = json['id'].toString();
  });
  doLogin();
  // print('user id= \n $_userid');
}

void doLogin() async {
  //simmpan user login ke alikasi(sahredPReferences or Cookies)
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("_username", _username);
  prefs.setString("_userid", _userid);
  main();
}

void doDaftar() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", 'daftarBaru');
  main();
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // untuk hide karakter pada paswword
  bool obscureText = true;

  // Toggles the password show status
  // ignore: unused_element
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Column(
              children: [
                Image.asset('./asset/image/clinic.jpg'),
                TextFormField(
                  onChanged: (value) {
                    _username = value;
                  },
                  decoration: InputDecoration(labelText: 'username'),
                ),
                TextFormField(
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: obscureText,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: obscureText,
                      onChanged: (value) {
                        setState(() {
                          obscureText = value;
                        });
                      },
                    ),
                    Text(
                      'sembunyikan password',
                    ),
                  ],
                ),
                SizedBox(
                  width: 500,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        bacaData();
                      },
                      child: Text(
                        'cek login',
                      )),
                ),
                Divider(),
                SizedBox(
                  width: 500,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        bacaData();
                      },
                      child: Text(
                        'MASUK',
                      )),
                ),
                SizedBox(
                    width: 500,
                    child: Text(
                      'Belum memiliki akun? \nSilahkan mendaftar',
                    )),
                SizedBox(
                  width: 500,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue[200],
                      ),
                      onPressed: () {
                        doDaftar();
                      },
                      child: Text(
                        'DAFTAR',
                        style: TextStyle(color: Colors.black54),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
