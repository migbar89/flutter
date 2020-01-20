import 'package:flutter/material.dart';
import 'package:flutter_app_gymapp/views/gimnasios.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gimnasios',
      debugShowCheckedModeBanner: false,
      home: GimnasiosView(),
    );
  }
}
