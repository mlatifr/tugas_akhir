import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: unused_element
String _username, _password;
Future<String> cekLogin() async {
  print('cek login function');
  final response = await http
      .post(Uri.parse("https://192.168.1.8/tugas_akhir/login.php"), body: {
    'id': 'pasien',
    'sandi': '',
  });
  print(response.body + 'response body adalah');
  if (response.statusCode == 200) {
    print('berhasil login');
  } else {
    throw Exception('Failed to read API');
  }
}

void doLogin() async {
  //simmpan user login ke alikasi(sahredPReferences or Cookies)
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_id", _username);
  main();
}

void doDaftar() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_id", 'daftarBaru');
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
                        cekLogin();
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
                        doLogin();
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
