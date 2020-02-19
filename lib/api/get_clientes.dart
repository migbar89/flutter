import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_gymapp/clientes.dart';

import '../clientes.dart';
import '../clientes.dart';

class GetClientes {
  List<Client> clientes;
  Firestore fs = Firestore.instance;
  final CollectionReference clientesREF = Firestore.instance.collection('gym');
  StreamSubscription<QuerySnapshot> clientesub;

  // Constructor de la clase
  GetClientes();

  // set clientes(List<Client> clientes) {}

  Stream<QuerySnapshot> getListaClientes({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = this.clientesREF.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  List<Client> consultarClientes(AsyncSnapshot<QuerySnapshot> snapshot) {
    this.clientes = new List<Client>();
    // Se agrega cada uno de los clientes de firestore a la lista de clientes local
    snapshot.data.documents.forEach((clienteFirestore) =>
        this.clientes.add(new Client.fromMap(clienteFirestore.data)));

    // Se retorna la lista de clientes de la clase
    return this.clientes;
  }

  Future<List<Client>> consultarClientes1() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("gym").getDocuments();
    var list = querySnapshot.documents
        .map((documentSnapshot) => Client.fromMap(documentSnapshot.data))
        .toList();
    return list;
  }
}
