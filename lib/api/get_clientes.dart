
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/clientes.dart';


class getclientes
{
  List<Client> clientes;
  Firestore fs = Firestore.instance;
  final CollectionReference clientesREF =
  Firestore.instance.collection('gym');
  StreamSubscription<QuerySnapshot> clientesub;

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

  void consultaclientes()
  {
    clientesub = this.getListaClientes().listen((QuerySnapshot snapshot) {
      final List<Client> pedidoss = snapshot.documents
          .map((documentSnapshot) => Client.fromMap(documentSnapshot.data))
          .toList();
      this.clientes = pedidoss;

    });

  }





}