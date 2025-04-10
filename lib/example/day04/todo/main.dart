// main.dart : 앱 실행의 최초 파일

// 1. main 함수 이용한 앱 실행
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/todo/Home.dart';
import 'package:tj2024b_app/example/day04/todo/Detail.dart';
import 'package:tj2024b_app/example/day04/todo/Write.dart';

void main(){
  runApp( MyApp() ); // 라우터를 갖는 위젯이 최초 화면
}
// 2. 라우터를 갖는 클래스/위젯
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/", // 앱이 실행 했을 때 초기
      routes: {
        "/" : (context) => Home(), // 만약에 "/" 해당 경로로 호출하면 Home 위젯이 열린다.
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        // "/update" : (context) => Update(),
      }
    );
  }
}