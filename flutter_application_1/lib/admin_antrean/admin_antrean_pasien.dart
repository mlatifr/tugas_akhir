import 'package:flutter/material.dart';
import '../main.dart';

class AdminAntreanPasien extends StatefulWidget {
  const AdminAntreanPasien({Key key}) : super(key: key);

  @override
  _AdminAntreanPasienState createState() => _AdminAntreanPasienState();
}

class _AdminAntreanPasienState extends State<AdminAntreanPasien> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Antrean Pasien")),
          ),
          drawer: widgetDrawer(),
          // body: ListView(
          //   children: [
          //     Padding(
          //         padding: EdgeInsets.all(10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Expanded(
          //                 child: TextFormField(
          //               enabled: false,
          //               decoration: InputDecoration(
          //                 labelText: 'Tanggal Lahir',
          //                 fillColor: Colors.white,
          //                 enabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(10.0),
          //                   borderSide: BorderSide(
          //                     color: Colors.blue,
          //                   ),
          //                 ),
          //               ),
          //             )),
          //             ElevatedButton(
          //                 onPressed: () {},
          //                 child: Icon(
          //                   Icons.calendar_today_sharp,
          //                   color: Colors.white,
          //                   size: 24.0,
          //                 ))
          //           ],
          //         )),
          //   ],
          // ),
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      print('end to start');
                    } else {
                      print('else');
                    }
                  },
                  confirmDismiss: (direction) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Konfirmasi'),
                            content:
                                Text('Apakah ingin menghapus antrian ini?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No')),
                            ],
                          );
                        });
                  },
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      size: 25,
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('${index + 1}'),
                    subtitle: Text('sub judul'),
                  ),
                );
              })),
    );
  }
}
