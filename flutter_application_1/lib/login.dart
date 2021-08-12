import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username, _password;
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
                    Text('sembunyikan password'),
                    Checkbox(
                      value: obscureText,
                      onChanged: (value) {
                        setState(() {
                          obscureText = value;
                        });
                      },
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text(
                        'MASUK',
                        // style: TextStyle(
                        //     color: Colors.white, backgroundColor: Colors.blue)
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
