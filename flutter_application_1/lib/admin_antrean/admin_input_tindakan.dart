import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminInputTindakan extends StatefulWidget {
  const AdminInputTindakan({Key key}) : super(key: key);

  @override
  _AdminInputTindakanState createState() => _AdminInputTindakanState();
}

class _AdminInputTindakanState extends State<AdminInputTindakan> {
  Widget widgetInputTindakan() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.27),
        TextFormField(
            maxLines: 1,
            // controller: keluhan,
            decoration: InputDecoration(
              labelText: "Nama Tindakan",
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        TextFormField(
            maxLines: 1,
            // controller: keluhan,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Harga Tindakan",
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Anda akan menginputkan tindakan:',
                        style: TextStyle(fontSize: 14),
                      ),
                      content: TextFormField(
                          enabled: false,
                          maxLines: 5,
                          // controller: keluhan,
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
                            // bacaDataKeluhan(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Text(
                'SIMPAN',
              )),
        ),
      ],
    );
  }

  Widget widgetListTindakan() {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: (context, index) {
          return Center(
              child: Text('${index + 1}\n_______________________________'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Input Tindakan'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: 150.0),
                  child: Material(
                    color: Colors.blue,
                    child: TabBar(
                      unselectedLabelColor: Colors.lightBlue[200],
                      labelColor: Colors.white,
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      indicatorColor: Colors.red,
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.medical_services,
                          ),
                          text: 'daftar tindakan',
                          iconMargin: EdgeInsets.only(bottom: 10.0),
                        ),
                        Tab(
                          icon: Icon(Icons.add_circle),
                          text: 'tambah',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      widgetListTindakan(),
                      widgetInputTindakan(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
