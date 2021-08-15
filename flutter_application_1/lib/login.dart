import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _username, _password;
// String cekUserName;
void doLogin() async {
  //nantinya ada pengecekan master_user melalui webservice
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_id", _username);
  main();
  // cekUserName = prefs.getString("user_id");
  // print(cekUserName);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // untuk hide karakter pada paswword
  bool obscureText = false;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          // padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                Divider(),
                SizedBox(
                  // width: MediaQuery.of(context).size.width,
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
                        'MASUK',
                      )),
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  // width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text(
                        'DAFTAR',
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
