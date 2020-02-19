

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/api/get_clientes.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';

import 'clientes.dart';
import 'datospublicos.dart';

final TextEditingController _searchField = new TextEditingController();

bool text_search = false;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home: SearchBar(),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return SearchBarState();
  }

}

class SearchBarState extends State {
  bool issearch = false;

  @override
  void initState() {


  } // List<Client> listacli = getcli.consultaclientes();


  SearchBarState() {
    _searchField.addListener(() {
      if (_searchField.text.isNotEmpty) {
        setState(() {
          issearch = true;
          text_search = true;

          // issearch=false;

        });
      }
      else {
        setState(() {
          text_search = true;
          // issearch=true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: !issearch ? Text("Gym App") :
            TextField(decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.white),
              hintText: "Buscando Cliente",
              hintStyle: TextStyle(color: Colors.white),


            ),
              autofocus: true,

              controller: _searchField,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              this.issearch ?
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    this.issearch = !this.issearch;
                    text_search = false;
                  });
                },
              ) :
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    this.issearch = !this.issearch;
                    text_search = false;
                  });
                },
              )
            ],

          ),
          body:
          busquedaestatica()
        //issearch ? (text_search? busqueda():datoscompletos() ): datoscompletos()

      ),
    );
  }

}

class busquedaestatica extends StatefulWidget {
  @override
  _busquedaestaticaState createState() => _busquedaestaticaState();
}

class _busquedaestaticaState extends State<busquedaestatica> {
  getclientes getcli = new getclientes();
  List<Client> listacli;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(getcli.consultaclientes());
    this.listacli = getcli.consultaclientes();
  }
  @override
  Widget build(BuildContext context) {

    print("Cantidad de Clientes="+listacli.length.toString());
    return Scaffold(
        body: listacli.length == 0 ?
        Center(
          child: Text(
            'Aun no hay ningun pedido registrado',
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
            itemCount: listacli.length,
            itemBuilder: (context,i)
            {
              // ignore: missing_return
              return _item_listview(
                  listacli[i].getnombre(), listacli[i].getapellido(), listacli[i].getId(), context);
            }

        )



    );
  }
}


class busqueda extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('gym').where(
          'nombre', isGreaterThanOrEqualTo: _searchField.text)
          .where('nombre', isLessThan: _searchField.text + 'z').snapshots(),
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

class datoscompletos extends StatelessWidget {


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
