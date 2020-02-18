/*


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/verinformacion.dart';
import 'datospublicos.dart';

import 'package:material_search/material_search.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
TextEditingController _searchQueryController = TextEditingController();
bool _isSearching = false;
String searchQuery = "Search query";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // burada ise layout u oluştururuz.
    // TODO: implement build
    return MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        Scaffold(
          appBar: AppBar(
            leading: _isSearching ? const BackButton() : Container(),
            title: _isSearching ? _buildSearchField() : _buildTitle(context),
            actions: _buildActions(),
          ),
        )
    );
  }
}
Widget _buildSearchField() {
  return TextField(
    controller: _searchQueryController,
    autofocus: true,
    decoration: InputDecoration(
      hintText: "Search Data...",
      border: InputBorder.none,
      hintStyle: TextStyle(color: Colors.white30),
    ),
    style: TextStyle(color: Colors.white, fontSize: 16.0),
    onChanged: (query) => updateSearchQuery,
  );
}

List<Widget> _buildActions() {
  if (_isSearching) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (_searchQueryController == null ||
              _searchQueryController.text.isEmpty) {
            Navigator.pop(context);
            return;
          }
          _clearSearchQuery();
        },
      ),
    ];
  }

  return <Widget>[
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: _startSearch,
    ),
  ];
}

void _startSearch() {
  ModalRoute.of(context)
      .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

  setState(() {
    _isSearching = true;
  });
}

void updateSearchQuery(String newQuery) {
  setState(() {
    searchQuery = newQuery;
  });
}

void _stopSearching() {
  _clearSearchQuery();

  setState(() {
    _isSearching = false;
  });
}

void _clearSearchQuery() {
  setState(() {
    _searchQueryController.clear();
    updateSearchQuery("");
  });
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

*/
