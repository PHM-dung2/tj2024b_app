// * myapp.dart : 앱 전체 구성 파일
// class 위젯명 extends 상태있는vs상태없는{}

import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';

class MyApp extends StatelessWidget{ // 상태 없는 위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 위젯명( key : value, key : value );
      // key : 위젯마다 정해진 key 사용한다.
      // value : key 적합한 다양한 하위 위젯들이 들어간다.
      title: "더조은앱", // 앱 탭 이름
      home: MainApp(), // 앱 본문
      theme: ThemeData( // 앱 테마
        scaffoldBackgroundColor: Colors.white // Scafforld 위젯의 색상 구성
      ), // 앱 테마
    );
  }
}