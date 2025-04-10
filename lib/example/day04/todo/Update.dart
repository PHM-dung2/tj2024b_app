// update.dart : 수정 화면 파일

// 상태 있는 위젯

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget{
  @override
  // State<StatefulWidget> createState() { // 안바꿔도 되지만 관례적으로 바꿈
  _UpdateState createState() {
    return _UpdateState();
  }
}
class _UpdateState extends State< Update >{ // 클래스명 앞에 _ 언더바는 dart에서 private 키워드

  // 1. 이전 위젯으로부터 전달받은 인수(arguments)를 가져오기
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // (1) 이전 위젯으로부터 전달받은 인수(arguments)를 가져오기\
    int id = ModalRoute.of( context )!.settings.arguments as int;
    print( id );
    // (2) 전달받은 인수(id)를 자바에게 보내고 응답객체 받기
    todoFindById( id );

  } // f end

  Dio dio = Dio();
  Map<String, dynamic> todo = {}; // JSON 타입은 key은 무조건 문자열 그래서 String, value는 다양한 자료타입이므로 dynamic

  void todoFindById( id ) async {
    try{
      // final response = await dio.get( "http://192.168.40.97:8080/day04/todos/view?id=$id" );
      final response = await dio.get( "http://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/todos/view?id=$id" );
      final data = response.data;
      if( data != null ) {
        setState(() {
          todo = data; // 응답받은 결과를 상태변수에 대입
          titleController.text = data['title'];
          contentController.text = data['content'];
          done = data['done'];
        });
        print( todo );
      }
    }catch( e ){ print( e ); }
  } // f end

  // 3. 입력컨트롤러
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  // 완료 여부를 저장하는 상태변수, 컨트롤러 없이 직접 렌더링
  dynamic done = true;

  void todoUpdate( ) async {
    final sendData = {
      "id" : todo['id'],
      "title" : titleController.text,
      "content" : contentController.text,
      "done" : done,
    };

    try{
      // final response = await dio.put( "http://192.168.40.97:8080/day04/todos", data: sendData );
      final response = await dio.put( "http://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/todos", data: sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed( context, "/" );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("수정 화면"), ),
      body: Center(
        child: Column(
          children: [
            SizedBox( height: 20, ),
            TextField(
              controller: titleController,
              decoration: InputDecoration( labelText: "할일 제목" ),
              maxLength: 30,
            ),

            SizedBox( height: 20, ),
            TextField(
              controller: contentController,
              decoration: InputDecoration( labelText: "할일 제목" ),
              maxLines: 5,
            ),

            SizedBox( height: 20, ),
            Switch( // 스위치 위젯, on/off 역할
                value: done, // 현재 스위치 값, true 또는 false
                onChanged: ( value ) => { // state 변경
                  setState(() { done = value; })
                }
                // onChanged : (변경된값) { setState( () { 상태변수 = 변경된값; } )
            ),

            SizedBox( height: 20, ),
            OutlinedButton(
                onPressed: todoUpdate,
                child: Text("수정")
            )
          ],
        )
      ),
    );
  }
}