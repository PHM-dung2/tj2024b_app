
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day05/Detail.dart';
import 'package:tj2024b_app/example/day05/Home.dart';
import 'package:tj2024b_app/example/day05/Update.dart';
import 'package:tj2024b_app/example/day05/Write.dart';

void main(){
  runApp( MyApp() );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => Home(),
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update(),
      },
    );
  }
}