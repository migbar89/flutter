import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/api/get_clientes.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';

import 'clientes.dart';
import 'clientes.dart';
import 'datospublicos.dart';

final TextEditingController _searchField = new TextEditingController();

bool text_search = false;

void main() => runApp(MyApp());

// Vista de la clase principal
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

// Vista para la barra de busqueda completa
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool issearch = false;

  @override
  Widget build(BuildContext context) {
    SearchBarState() {
      _searchField.addListener(() {
        if (_searchField.text.isNotEmpty) {
          setState(() {
            issearch = true;
            text_search = true;

            // issearch=false;
          });
        } else {
          setState(() {
            text_search = true;
            // issearch=true;
          });
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: !issearch
              ? Text("Gym App")
              : TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.white),
                    hintText: "Buscando Cliente",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  autofocus: true,
                  controller: _searchField,
                  style: TextStyle(color: Colors.white),
                ),
          actions: <Widget>[
            this.issearch
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.issearch = !this.issearch;
                        text_search = false;
                      });
                    },
                  )
                : IconButton(
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
        body: BusquedaEstatica()
        //issearch ? (text_search? busqueda():datoscompletos() ): datoscompletos()
        );
  }
}

// Vista par la busqueda estatica
class BusquedaEstatica extends StatefulWidget {
  @override
  _BusquedaEstaticaState createState() => _BusquedaEstaticaState();
}

class _BusquedaEstaticaState extends State<BusquedaEstatica> {
  GetClientes getClientes = new GetClientes();
  List<Client> listaClientes = new List<Client>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Cantidad de Clientes=" + listaClientes.length.toString());

    // se crea un stream para observar los datos de firestore en tiempo real
    return StreamBuilder<QuerySnapshot>(
      // se realiza el query a la coleccion de gimnasios
      stream: Firestore.instance.collection('gym').snapshots(),

      // Se crea el metodo builder para construir los datos a partir de la consulta
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // se determina si la consulta retorno algun error
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

        // se determina el estado actual de la consulta
        switch (snapshot.connectionState) {
          // en caso de que aun este consultando los datos
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );

          // en caso de que los datos ya hayan sido consultados
          default:
            // se asigna la lista de clientes a la variable de clientes local a la clase
            this.listaClientes = getClientes.consultarClientes(snapshot);

            // se retornan los datos ya mapeados
            return this.listaClientes.length != 0

                // En caso de que la lista contenga datos
                ? ListView.builder(
                    itemCount: listaClientes.length,
                    itemBuilder: (context, i) {
                      // ignore: missing_return
                      return _item_listview(
                          this.listaClientes[i].getnombre(),
                          this.listaClientes[i].getapellido(),
                          this.listaClientes[i].getapellido(),
                          context);
                    },
                  )

                // En caso de que la lista no contenga datos
                : Center(
                    child: Text(
                      'Aun no hay ningun cliente registrado',
                      textAlign: TextAlign.center,
                    ),
                  );
        }
      },
    );
  }
}

class busqueda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('gym')
          .where('nombre', isGreaterThanOrEqualTo: _searchField.text)
          .where('nombre', isLessThan: _searchField.text + 'z')
          .snapshots(),
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
                  child: _item_listview(
                    document['nombre'],
                    document['apellido'],
                    document['id'],
                    context,
                  ),
                );
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

Widget _item_listview(
    String nombre, String apellido, String id, BuildContext context) {
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
