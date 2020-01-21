import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/agregar_cliente.dart';
import 'package:flutter_app_gymapp/classes/Gimnasio.dart';
import 'dart:async';

class GimnasiosView extends StatefulWidget {
  GimnasiosView({Key key}) : super(key: key);

  @override
  _GimnasiosViewState createState() => _GimnasiosViewState();
}

class _GimnasiosViewState extends State<GimnasiosView> {
  List<Gimnasio> gimnasios;
  Firestore fs = Firestore.instance;

  StreamSubscription<QuerySnapshot> gimnasiosSub;

  Stream<QuerySnapshot> getListaGimnasios({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = this.fs.collection('gym').snapshots();

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgregarClienteView(),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
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
