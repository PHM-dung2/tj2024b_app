
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){ // 프로그램 진입점
  // 방법1. 메뉴 상단에 'select device'에서 'web'선택 후 실행
  // 방법2. 1. Device manager' 해당하는 디바이스 실행
  //        2. 메뉴 상단에 'select device'에서 실행된 디바이스 선택 후 실행
  // runApp( MyApp1() ); // runApp( 출력할클래스() );
  runApp( MyApp2() );
} // f end

// (1) 간단한 화면 만들기, class 클래스명 extends StatelessWidget{}
// StatelessWidget : 상태가 없는 인터페이스
//    -> build : 하나의 추상메소드를 제공한다.
class MyApp1 extends StatelessWidget{
  // 컨트롤 + 스페이스바 : build 함수 재정의(오버라이딩)
  @override
  Widget build(BuildContext context) {
    // 기존 코드 지우고 return 출력할 위젯
    return MaterialApp( home: Text("안녕하세요 플러터, 리로드") );
  } // f end
} // class end

// (2) 간단한 레이이웃 화면 만들기
class MyApp2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // return MaterialApp( home: Scaffold() );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( title: Text("여기는 상단메뉴") ),  // 상단메뉴바
        body: Center( child: Text("여기는 본문") ), // 본문
        bottomNavigationBar: BottomAppBar( child: Text("여기는 하단 메뉴") ), // 하단메뉴바
      )
    );
  }
}