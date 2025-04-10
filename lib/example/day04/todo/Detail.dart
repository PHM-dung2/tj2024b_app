// view.dart : 상세 화면 파일

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
}
class _DetailState extends State< Detail >{
  // * 1. 이전 화면에서 argument 값을 가져오기( queryString과 비슷 )
    // 전제조건 : Navigetor.pushNamed( context, "/detail", arguments : todo['id'] )
    // ModalRoute.of( context )!.settings.arguments as int;

    // (1) initState()해당 위젯이 최초로 딱 1번 실행하는 함수( 위젯 생명주기 ), context 위젯트리를 제공받을 수 없다
    // (2) didChangeDependendies() 부모 위젯이 변경되었을 때 실행되는 함수( 위젯 생명주기 ) context 위젯트리를 제공받는다.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of( context )!.settings.arguments as int;
    todoFindById( id ); // 가져온 id를
  }

  // *2. 자바와 통신하여 id에 해당하는 상세 정보 요청
  Dio dio = Dio();
  Map<String, dynamic> todo = {}; // 응답 결과를 저장하는 하나의 '일정' 객체 선언
  void todoFindById( id ) async {
    try{
      // final response = await dio.get( "http://192.168.40.97:8080/day04/todos/view?id=$id" );
      final response = await dio.get( "http://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/todos/view?id=$id" );
      final data = response.data;
      if( data != null ) {
        setState(() {
          todo = data; // 응답받은 결과를 상태변수에 대입
        });
        print( todo );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {

    int id = ModalRoute.of( context )!.settings.arguments as int;
    print( id );

    return Scaffold(
      appBar: AppBar( title: Text("상세 화면"), ),
      body: Center(
        child: Column(
          children: [
            Text( "제목 : ${ todo['title'] }", style: TextStyle( fontSize: 18 ),),
            Text( "내용 : ${ todo['content'] }", style: TextStyle( fontSize: 15 ),),
            Text( "완료 여부 : ${ todo['done'] }", style: TextStyle( fontSize: 13 ),),
            Text( "할일 등록일 : ${ todo['createAt'] }", style: TextStyle( fontSize: 13 ),),
          ],
        ),
      )
    );
  }
}