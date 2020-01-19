import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_gymapp/agregar_cliente.dart';
import 'package:flutter/material.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

import 'clientes.dart';

void main() => runApp(MyApp());
//void main() => runApp(MyStatelessWidget());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}


final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Next page1'),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

/*
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('gym').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['nombre']),
                  subtitle: new Text(document['apellido']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}

 */

/// This is the stateless widget that the main application instantiates.

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

       // body: new ListView(children:clientes.map(_item_listview).toList(),
        )
    );
  }
}


getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data.documents
      .map((doc) => new ListTile(title: new Text(doc["nombre"]), subtitle: new Text(doc["apellido"].toString())))
      .toList();
}

Widget _item_listview(Client textTitle) {
  return new ListTile(
    title: new Text(textTitle.nombre),
    subtitle: new Text(textTitle.apellido),
    leading: new Icon(Icons.map),
    onTap: (){
      _tappedFolder(textTitle.nombre);
    },
  );
}

void _tappedFolder(String which) {
  print("tapped");
}
