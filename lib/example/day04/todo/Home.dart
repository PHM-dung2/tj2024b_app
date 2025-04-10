// home.dart : 메인 화면 갖는 앱의 파일

// 1. 상태 있는 위젯
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState(){
    return _HomeState();
  }
} // c end
// dart에서는 클래스/변수명 앞에 _(언더바) private 뜻한다.
class _HomeState extends State< Home >{
  Dio dio = Dio(); // 1. dio 객체 생성
  List<dynamic> todoList = []; // 2. 할일 목록을 저장하는 리스트 선언
  // 3. 자바와 통신하여 할일 목옥을 조회하는 함수 선언
  void todoFindAll() async {
    try{
      final response = await dio.get( "http://192.168.40.97:8080/day04/todos" );
      final data = response.data;
      // 조회 결과 없으면 [], 조회 결과가 있으면 [ {}, {}, {} ]
      // setState 이용하여 재 렌더링한다.
      setState(() {
        todoList = data; // 자바로부터 응답받은 결과를 상태변수에 저장한다.
      });
      print( todoList );
    }catch( e ){ print( e ); }
  } // f end
  // 4. 화면이 최초로 열렸을 때 딱 1번 실행, .initState(){ 함수명(); }
  @override
  void initState(){
    super.initState();
    todoFindAll(); // 해당 위젯이 최초로 열렸을 때 자바에게 할일 목록 조회 함수 호출
  }

  // 5. 삭제 이벤트 함수
  void todoDelete( int id ) async{
    try{
      final response = await dio.delete( "http://192.168.40.97:8080/day04/todos?id=$id" );
      final data = response.data;
      if( data ){ todoFindAll(); } // 삭제 성공시 할일목록 다시 호출하기
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("메인 페이지 : TODO"), ),
      body: Center(
        child: Column(
          children: [

            // (1) 등록 화면으로 이동하는 버튼
            TextButton( // 등록 화면으로 이동하는 버튼
                onPressed: () => { Navigator.pushNamed(context, "/write") },
                child: Text("할일 추가")
            ),
            // (2) 간격
            SizedBox( height: 30,),

            // (3) ListView 이용한 할일 목록 출력
            // 자바로부터 가져온 할일목록을 map 함수를 이용하여 반복해서 Card 형식의 위젯 만들기
            Expanded( // Column 위젯 안에서 ListView 사용시 Expanded 위젯 안에서 사용한다.
                child: ListView( // ( <ol> )ListView 위젯은 높이 100%의 자동 세로 스크롤 지원하는 위젯
                    // children: [] // [] 대신에 map 반복문
                  children: todoList.map( (todo){

                    return Card( child: ListTile(
                        title: Text( todo["title"] ), // 제목
                        subtitle: Column(
                          children: [ // dart 언어에서 문자와 변수를 철력하는 방법
                            // 방법1 : 변수값만 출력할 경우에는, " 문자열 $변수명 "
                            // 방법2 : 변수안에 key의 값을 출력할 경우에는, " 문자열 ${ 변수명['key'] }"
                            Text( "할일내용 : ${ todo['content'] }" ),
                            Text( "할일상태 : ${ todo['done'] }" ),
                            Text( "등록일 : ${ todo['createAt'] }" ),
                          ],
                        ),
                        // trailing : ListTile 오른쪽 끝에 표시되는 위젯
                        trailing: Row( // 하위 위젯들을 가로 배치 vs Column
                          mainAxisSize: MainAxisSize.min, // 배치 방법, 오른쪽 위젯들의 넓이를 자동으로 할당
                          children: [ // Row 위젯의 자식들
                            IconButton(
                                onPressed: () => { Navigator.pushNamed( context, "/detail", arguments: todo['id'] ) },
                                icon: Icon( Icons.info_outline )
                            ),
                            IconButton(
                                onPressed: () => { todoDelete( todo['id'] ) },
                                icon: Icon( Icons.close )
                            ),
                          ],
                        )
                      )
                    ); // ;(세미콜론) return 마다
                  }).toList(),
                )
            )
          ],
        ),
      )
    );
  }
}

/*
  Expanded( // Column 위젯 안에서 ListView 사용시 Expanded 위젯 안에서 사용한다.
      child: ListView( // ( <ol> )ListView 위젯은 높이 100%의 자동 세로 스크롤 지원하는 위젯
        children: [
          ListTile( title: Text("항목1"),), // ( <li> )
          ListTile( title: Text("항목2"),) // ( <li> )
        ]
      )
  ) 
  
  리스트명.map( (반복변수명){
    return 위젯명();
  }).toList()

*/