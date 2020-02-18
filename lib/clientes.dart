import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Client {
   String id;
   String nombre;
   String apellido;
   String direccion;
   String telefono;

   Client({
    this.id,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefono
  });
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (this.id != null) {
      map[''] = this.id;
    }
    map['nombre'] = this.nombre;
    map['apellido'] = this.apellido;
    map['direccion'] = this.direccion;
    map['telefono'] = this.telefono;


    return map;
  }
  String getId() => this.id;

  String getnombre() => this.nombre;

  String getapellido() => this.apellido;

  String getdireccion() => this.direccion;

  String gettelefono() => this.telefono;

   Client.fromMap(Map<String, dynamic> map) {

    this.id = map['id'];
    this.nombre = map['nombre'];
    this.apellido = map['apellido'];
    this.direccion = map['direccion'];
    this.telefono = map['telefono'];


  }




}
/*
void loadclientes() {
  var firestore = Firestore.instance;
  Stream snapshot = firestore.collection("gym").snapshots();

  var temporalList = new List<Client>();
  for (DocumentSnapshot doc in snapshot.data.documents) {
    temporalList.add(new Client(
        id: doc.documentID,
        nombre: doc['nombre'],
        apellido: doc['apellido'],
        telefono:doc['telefono'],
        direccion: doc['direccion'])
    );
  }

  clientes=temporalList;
}*/

//var clientes=loadclientes();
/*var clientes = [
  new Client(nombre:'Belarus',apellido:'Minsk',direccion:'Europe',telefono: '9498700'),
  new Client(nombre:'Bulgaria',apellido:'Sofia',direccion:'Europe',telefono: '7153784'),
  new Client(nombre:'Czech Republic',apellido:'Prague',direccion:'Europe',telefono: '10558524'),
  new Client(nombre:'Denmark',apellido:'Copenhagen',direccion:'Europe',telefono: '5717014'),
  new Client(nombre:'Italy',apellido:'Rome',direccion:'Europe',telefono: '60665551'),
  new Client(nombre:'Liechtenstein',apellido:'Vaduz',direccion:'Europe',telefono: '37623'),
  new Client(nombre:'Norway',apellido:'Oslo',direccion:'Europe',telefono: '5223256'),
  new Client(nombre:'Spain',apellido:'Madrid',direccion:'Europe',telefono: '46438422'),
  new Client(nombre:'Sweden',apellido:'Stockholm',direccion:'Europe',telefono: '9894888'),
  new Client(nombre:'Ukraine',apellido:'Kiev',direccion:'Europe',telefono: '42692393'),
];
*/