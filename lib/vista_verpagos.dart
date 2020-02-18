import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'agregar_Pago.dart';
import 'datospublicos.dart';

class vista_verpagos extends StatelessWidget {
  vista_verpagos(BuildContext context);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Informacion'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.monetization_on),
                tooltip: 'Agregar Pago',
                onPressed: ()
                {
                  // scaffoldKey.currentState.showSnackBar(snackBar);
                  add_Pago(context);

                },
              ),]
        ),
        body: vista_verinformacion(context)
    );
  }
}

Widget vista_verinformacion(BuildContext context)
{

  return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(nombrecliente,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xff5A8CD8),
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('gym').document(idclienteselect).collection("Pagos").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                return new ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Material(
                        child: _item_listview_pagos(document['monto'], document['fecha'],document.documentID,context)

                    );
                  }).toList(),
                );
            }
          },
        ),



      ]

  );
}
Widget _item_listview_pagos(int monto,String fecha,String id,BuildContext context) {
  return new ListTile(
    title:  new Text(monto.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
    subtitle: new Text(fecha,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

    leading: new Icon(Icons.monetization_on),
    onTap: (){

      //ver_informacion(context);
      // idclienteselect=id;
      //nombrecliente=nombre;
      // getnombre();
    },
  );
}
