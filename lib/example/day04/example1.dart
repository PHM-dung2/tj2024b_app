// 위젯 : 화면을 그려내는 최소 단위
// 위젯명( 속성명 : 위젯명, 속성명 : 위젯명 );         = 객체
// vs new 클래스명( 매개변수 , 매개변수, 매개변수 );   = 객체

import 'package:flutter/material.dart';

// 1. 플러터 시작, 시작점에서 runApp()에서 최초로 실행할 위젯의 객체 대입
void main(){
  // run App( 최초시행할위젯 );
  runApp(
      MaterialApp(
        initialRoute : "/", // 최초로 실행했을 때 열리는 경로 정의
        // routes: { "경로정의" : ( context ) => 위젯명, "경로정의" : ( context ) => 위젯명, },
        routes: {
          "/" : ( context ) => Home(),
          "/page1" : ( context ) => Page1(),
        },
      )

  );
} // main end

// 2. 앱 화면 만들기, 2가지 선택사항 : 1.상태없는 2.상태있는
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("메인페이지 헤더"),),
      body: Center(
        child: Column(
          children: [
            Text("메인페이지 본문"),
            TextButton(
                onPressed: () => { Navigator.pushNamed(context, "/page1") }, //
                child: Text("page1로 이동 버튼")
            )
          ],
        ),
      )
    );
  }
} // c end

class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("PAGE1 헤더"),),
      body: Center( child: Text("본문"), ),
    );
  }
} // c end


