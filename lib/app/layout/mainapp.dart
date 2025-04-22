// * mainapp.dart :
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/member/Info.dart';
import 'package:tj2024b_app/app/member/login.dart';
import 'package:tj2024b_app/app/member/signup.dart';

class MainApp extends StatefulWidget{
  @override
  _MainAppState createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State< MainApp >{

  // 1. 페이지 위젯 리스트 : 여러개 위젯들을 갖는 리스트
    // Widget : 여러 위젯들을 상속하는 상위 위젯( 클래스 )
  List<Widget> pages = [
    Text("홈 페이지"),
    Text("게시물1 페이지"),
    Text("게시물2 페이지"),
    Info(),
  ];
  // 2. 페이지 상단 제목 리스트
  List<String> pageTitle = [
    '홈',
    '게시물1',
    '게시물2',
    '내정보'
  ];
  // 3. 현재 클릭된 페이지 번호 : 상태 변수
    // 0 : 홈, 1 : 게시물, 2 : 내정보
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // 상단 메뉴
        title: Row( // 가로배치
          children: [ // 가로배치할 하위 위젯
            // 로컬 이미지(플러터) vs 네드워크 이미지(Spring서버)
            // 프로젝트폴더 -> assets(폴더생성) -> image(폴더생성) -> logo.jpg
            // 프로젝트폳더 -> pubsepec.yaml -> 대략 56번째 flutter: 작성된 곳에서
            Image(
              image: AssetImage('assets/images/logo.jpg'),
              height: 50, // 세로 크기
              width: 50, // 가로 크기
            ), // 로컬 이미지 : Image(image: AssetImage('코컬이미지경로') )
            Text( pageTitle[ selectedIndex ] ), // 현재 선택된 위젯의 제목 반환

          ]
        ),
        backgroundColor: Colors.white,
      ),
      body: pages[ selectedIndex ], // * 본문 : 현재 선택된 위젯들을 보여주기  *
      bottomNavigationBar: BottomNavigationBar( // 하단 메뉴
        // onTap : BottomNavigationBar에서 해당하는 버튼 클릭했을 때 발생하는 이벤트
          // (index) => 함수명(index) : items에서 선택된 index 인덱스 번호 반환된다.
        onTap: ( index ) => setState( () { selectedIndex = index; }) , // 해당 버튼 위젯들을 클릭했을 때 발생하는 이벤트 속성
        currentIndex: selectedIndex, // 현재 선택된 버튼 번호
        type: BottomNavigationBarType.fixed, // 4개 이상일 때 아이콘 고정 크기 설정, 아이콘이 많아지면 자동으로 확태/ 축소
        items: [ // 여러 개 버튼 위젯들
          BottomNavigationBarItem( icon: Icon( Icons.home ), label: '홈' ), // 아이콘 위젯
          BottomNavigationBarItem( icon: Icon( Icons.forum ), label: '게시물' ),
          BottomNavigationBarItem( icon: Icon( Icons.forum ), label: '게시물2' ),
          BottomNavigationBarItem( icon: Icon( Icons.person_search ), label: '내정보(회원가입)' ),
        ],
      )
    );
  }
}