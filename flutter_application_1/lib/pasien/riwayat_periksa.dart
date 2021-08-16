import 'package:flutter/material.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class RiwayatPeriksaPasien extends StatefulWidget {
  const RiwayatPeriksaPasien({Key key}) : super(key: key);

  @override
  _RiwayatPeriksaPasienState createState() => _RiwayatPeriksaPasienState();
}

class _RiwayatPeriksaPasienState extends State<RiwayatPeriksaPasien> {
  final List<Item> _data = generateItems(8);
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Periksa'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                _buildPanel(),
                Row(
                  children: <Widget>[
                    Text('Profil'),
                    Text('Rekam Medis'),
                    Text('Nama'),
                    Text('Usia'),
                  ],
                ),
                Text('tgl visit'),
                Text('keluhan'),
                Text('Riwayat Alergi'),
                Text('anamnesis'),
                Text('tindakan'),
                Text('Resep'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
