import 'dart:convert';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: unused_element
String username, password, userid;
Future<String> fetchDataLogin() async {
  // print('cek login function');
  final response = await http.post(Uri.parse(APIurl + "login.php"), body: {
    'id': username,
    'sandi': password,
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

void doLogin() async {
  //simmpan user login ke alikasi(sahredPReferences or Cookies)
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("_username", username);
  // print('$userid: milik login');
  prefs.setString("userid", userid);
  // print('$userid: milik login2');
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
  // tahap 2 API 1
  bacaDataLogin(context) {
    Future<String> data = fetchDataLogin();
    data.then((value) {
      //Mengubah json menjadi Array
      Map json = jsonDecode(value);
      // print(json);
      // print('json id nya adalah =' + json['id'].toString());

      if (json['result'].toString().contains('success')) {
        // print(json);
        setState(() {
          userid = json['id'].toString();
        });
        print(username.toString() +
            ' ' +
            password.toString() +
            ' ' +
            userid.toString());
        doLogin();
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'username atau password tidak sesuai',
              style: TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        // print('salah : \n');
        // print(json.toString());
      }
    });
    // print('user id= \n $_userid');
  }

  @override
  void initState() {
    super.initState();
    username = null;
    userid = null;
    password = null;
  }

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    './asset/image/clinic_text.jpg',
                    // './asset/image/clinic1.jpg',
                    // width: MediaQuery.of(context).size.width * 0.50,
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: InputDecoration(labelText: 'username'),
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
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
                Divider(),
                SizedBox(
                  width: 500,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        print(username.toString() +
                            ' ' +
                            password.toString() +
                            ' ' +
                            userid.toString());
                        if (password == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'username / password tidak ditemukan ',
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else if (username == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'username / password tidak ditemukan ',
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else if (username == null && password == null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'username / password tidak ditemukan ',
                                style: TextStyle(fontSize: 14),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else if (username != null && password != null) {
                          bacaDataLogin(context);
                        }
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
