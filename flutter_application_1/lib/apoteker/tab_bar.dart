import 'package:flutter/material.dart';

class TabBarTest extends StatefulWidget {
  const TabBarTest({Key key}) : super(key: key);

  @override
  _TabBarTestState createState() => _TabBarTestState();
}

Widget WgGridViewBuilderStok() {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: obatStoks.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          child: Text(obatStoks[index]["name"]),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(15)),
        );
      });
}

Widget WgGridViewBuilderKalauarsa() {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: obatKadaluarsas.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          child: Text(obatKadaluarsas[index]["name"]),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(15)),
        );
      });
}

Widget WgGridViewBuilderNama() {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: obatNamas.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          child: Text(obatNamas[index]["name"]),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(15)),
        );
      });
}

final List<Map> obatStoks =
    List.generate(10, (index) => {"id": index, "name": "Stok $index"}).toList();
final List<Map> obatKadaluarsas =
    List.generate(10, (index) => {"id": index, "name": "Kadaluarsa $index"})
        .toList();
final List<Map> obatNamas =
    List.generate(10, (index) => {"id": index, "name": "Nama $index"}).toList();

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: WgGridViewBuilderStok())));
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: WgGridViewBuilderKalauarsa())));
  }
}

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: WgGridViewBuilderNama())));
  }
}

class _TabBarTestState extends State<TabBarTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('Daftar Stok Obat'),
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  color: Colors.indigo,
                  child: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
