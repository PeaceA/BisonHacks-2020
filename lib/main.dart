import 'package:flutter/material.dart';
import 'package:bridge_it/dashboard.dart';
import 'package:bridge_it/utils/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Colors.white,
      ),
      home: new Dashboard(auth: new FirebaseAuth()),
    );
  }
}