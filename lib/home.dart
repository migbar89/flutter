import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';
import 'package:flutter_app_gymapp/vista_verpagos.dart';

import 'agregar_Pago.dart';
import 'datospublicos.dart';


class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
          new Text("Home",style: new TextStyle(fontWeight:FontWeight.bold),),
        ],
      ),
    );
  }
}
