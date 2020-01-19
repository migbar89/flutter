import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/agregar_cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/classes/Gimnasio.dart';
import 'dart:async';

import 'clientes.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatefulWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  List<Gimnasio> gimnasios;
  Firestore fs = Firestore.instance;
  final CollectionReference gimnasiosRef = Firestore.instance.collection('gym');

  StreamSubscription<QuerySnapshot> gimnasiosSub;

  Stream<QuerySnapshot> getListaGimnasios({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = this.gimnasiosRef.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.gimnasios = new List();

    gimnasiosSub = this.getListaGimnasios().listen((QuerySnapshot snapshot) {
      final List<Gimnasio> gimnasioss = snapshot.documents
          .map((documentSnapshot) => Gimnasio.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.gimnasios = gimnasioss;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    gimnasiosSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gimnasios'),
      ),
      drawer: Drawer(),
      body: this.gimnasios.length == 0
          ? Center(
              child: Text(
                'Aun no hay ningun gimnasio registrado',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: this.gimnasios.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListTile(
                    title: Text(this.gimnasios[i].getNombre()),
                    subtitle: Text(this.gimnasios[i].getApellido()),
                    onTap: () {
                      print("Element touched");
                    },
                  ),
                );
              },
            ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
/*
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Gym Control'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person_add),
              tooltip: 'Show Snackbar',
              onPressed: () {
                // scaffoldKey.currentState.showSnackBar(snackBar);
                add_cliente(context);

              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Next page',
              onPressed: () {
                openPage(context);
              },
            ),
          ],
        ),

        body:
        )
        )
    );
  }
}

*/
getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data.documents
      .map((doc) => new ListTile(
          title: new Text(doc["nombre"]),
          subtitle: new Text(doc["apellido"].toString())))
      .toList();
}

Widget _item_listview(Client textTitle) {
  return new ListTile(
    title: new Text(textTitle.nombre),
    subtitle: new Text(textTitle.apellido),
    leading: new Icon(Icons.map),
    onTap: () {
      _tappedFolder(textTitle.nombre);
    },
  );
}

void _tappedFolder(String which) {
  print("tapped");
}
