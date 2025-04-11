
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day06/Detail.dart';
import 'package:tj2024b_app/example/day06/Home.dart';
import 'package:tj2024b_app/example/day06/Update.dart';
import 'package:tj2024b_app/example/day06/Write.dart';

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