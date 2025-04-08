// 상태위젯 + Rest통신
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// 1. main함수
void main(){
  runApp( MyApp() );
}
// 2. 상태 관리 클래스 선언, StatefulWidget 상속 받으면 꼭 createState() 재정의한다.
class MyApp extends StatefulWidget{
  // - 상태 위젯과 연결
    // 방법1 // MyAppState createState(){ return MyAppState(); }
    // 방법2 // MyAppState createState() => MyAppState();
  MyAppState createState() => MyAppState();

}

class MyAppState extends State< MyApp >{
  Dio dio = new Dio(); // Dio라는 객체 생성, fetch/axios
  // * 상태변수
  String responseText = "서버응답 결과가 표시되는 곳";
  // dio 라이브러리 이용하여 REST 통신하는 함수
  void todoSend() async {
    try{
      // 샘플 데이터
      final sendData = { "title" : "운동하기", "content" : "매일10분달리기", "done" : false }; // 본문 예씨
      final response = await dio.post( "http://192.168.40.97:8080/day04/todos", data : sendData );
      final data = response.data; // 응답에서 body(본문) 결과만 추출
      // 응답 결과를 상태에 저장, setState() 함수를 이용한 상태 렌더링
      setState(() {
        responseText = "응답결과 : $data"; // 상태변수에 새로운 값 대입한다.
      });
    }catch( e ){
      setState(() {
        responseText = "에러발생 : $e";
      });
    }
  } // f end

  // * dio 라이브러리 이용하여 REST 통신하는 함수
  List< dynamic > todoList = [];
  // dynamic , List< dynamic > , * List< Map<String, String> > * (제일 안전, JSON에 제일 근접)

  void todoGet() async {
    try{
      final response = await dio.get( "http://192.168.40.97:8080/day04/todos" );
      final data = response.data;
      print( data );
      // 응답 결과를 상태변수에 대입한다. .setState()
      setState(() {
        todoList = data; // 빈 리스트에 응답 결과를 대입한다.
      });
    }catch( e ){
      print( e );
    }
  } // f end

  // * 위젯이 실행했을 때 최초로 1번 실행하는 함수
  @override
  void initState(){
    super.initState();
    todoGet(); // 모든 할일 목록 가져오기 함수 실행
  } // f end

  @override // setState 실행될 때 마다 다시 실행된다.
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body : Center(
          child: Column(
            children: [
              Text( responseText ),       // (1) 텍스트 위젯

              OutlinedButton(             // (2) 버튼 위젯
                  onPressed: todoSend , // 클릭했을 때 이벤트
                  child: Text("자바통신") // 버튼에 표시할 텍스트
              ),

              OutlinedButton(             // (3) 버튼 위젯
                  onPressed: todoGet ,
                  child: Text("자바통신2")
              ),

              Expanded(                   // (4) 확장 위젯 : Expanded : Column 남은 공간을 모두 채워주는 위젯
                  child: ListView( // ListView 위젯 : 스크롤이 가능한 목록(리스트), 주의할점 : 부모 요소의 100% 높이 사용한다.
                    // 1. 샘플 예시1
                    // children: [
                    //   ListTile( title: Text("플러터") ),
                    //   ListTile( title: Text("다트") ),
                    //   ListTile( title: Text("파이썬") )
                    // ]
                    // 2. 샘플 예시2
                      // 방법1 * 상태변수에 있는 모든 값들을 바복문 이용하여 출력하기

                    // children: [
                    //    for( int i = 0 ; i < todoList.length ; i++ ) // 상태변수에 저장된 할일 목록을 순회한다.
                    //    ListTile( title : Text( todoList[i]['title'] )) // index 번쨰의 할일 제목을 ListTile 위젯에 Text 대입
                    // ]

                    // 3. 샘플 예시3
                      // 방법2 * map 이란 : 각 리스트/배열의 요소들을 하나씩 순회하여 새로운 리스트/배열 반환 *
                    children: todoList.map( ( todo ) {
                        return ListTile( title: Text( todo['title'] ), subtitle: Text( todo['content'] ), );
                      }).toList() // => 생략 가능 // 리스트/배열명.map( (반복변수){ return 위젯명(); } ).toList()
                    // dynamic todoList = []; , map에서는 오류가 발생한다. List 타입이 아니라서 map 작동 불가능하다.
                    // List< dynamic > todoList = []; , map에서 정상 작동한다.
                  )
              ),
            ], // Column 하위 위젯 end
          ),
        )
      ),
    );
  }
}

// ctrl+alt+L