import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';
import 'package:flutter_app_gymapp/vista_verpagos.dart';

import 'agregar_Pago.dart';
import 'datospublicos.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';
import 'package:flutter_app_gymapp/vista_verpagos.dart';

import 'agregar_Pago.dart';
import 'datospublicos.dart';
/*
https://www.developerlibs.com/2018/06/flutter-apply-search-box-in-appbar.html
*/
List<String> items;
class vista_clientes extends StatefulWidget {

  _vista_clientesState createState() => _vista_clientesState();
}







class _vista_clientesState extends State<vista_clientes> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('gym').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Material(
                    child: _item_listview(document['nombre'],
                        document['apellido'], document.documentID, context));
              }).toList(),
            );
        }
      },
    );
  }
}

  Widget _item_listview(String nombre, String apellido, String id,
      BuildContext context) {
    return new ListTile(
      title: new Text(nombre,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff5A8CD8))),
      subtitle: new Text(apellido,
          style: TextStyle(fontSize: 16, color: Color(0xff09090A))),
      leading: new Icon(Icons.people),
      onTap: () {
        _tappedFolder(id);
        idclienteselect = id;
        nombrecliente = nombre;
        //ver_informacion(context);
        ver_informacion(context);

        // getnombre();
      },
    );
  }

  void _tappedFolder(String which) {
    print(which);
  }
