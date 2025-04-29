
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/member/login.dart';
import 'package:tj2024b_app/app/util/serverUrl.dart';

// String memberPath = 'http://192.168.40.97:8080/member';

class Info extends StatefulWidget{
  @override
  _InfoState createState() {
    return _InfoState();
  }
}

class _InfoState extends State< Info >{
  // 1. 상태변수
  int mno = 0;
  String memail = "";
  String mname = "";

  // 2. 해당 페이지(위젯) 열렸을 때 실행되는 함수
  @override
  void initState() {
    loginCheck();

  }

  // 3. 로그인 상태를 확인하는 함수
  bool? isLogIn; // Dart문법 중에 type? 는 null 포함할 수 있다 뜻
  void loginCheck() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if( token != null && token.isNotEmpty ){ // 전역변수에 (로그인)토큰이 존재하면
      setState(() {
        isLogIn = true; print("로그인 중");
        onInfo( token ); // 로그인 중일 때 로그인 정보 요청 함수 실행
      });
    }else{
      // Navigator.pushReplacement( context , MaterialPageRoute (builder: ( context ) => 이동할위젯명() ) );
      Navigator.pushReplacement( context , MaterialPageRoute( builder: ( context ) => Login() ) );
    }
  }

  // 4. 로그인된 (회원)정보 요청, 로그인 중일때 실행
  Dio dio = Dio();
  Map<String, dynamic> book = {};

  void onInfo( token ) async {
    try{
      // * Dio에서 Headers 정보를 보내는 방법, Options
      // 방법1 : dio.options.headers['속성명'] = 값;
      // 방법2 : dio.get( option : { headers : { '속성명' : 값 } } )
      dio.options.headers['Authorization'] = token;
      final response = await dio.get( "${ServerUrl}/member/info" );
      final data = response.data;
      if( data != '' ){
        setState(() {
          memail = data['memail'];
          mname = data['mname'];
          mno = data['mno'];
        });
      }else{ print('조회 실패'); }
    }catch( e ){ print( e ); }
  } // f end

  // 5. 로그아웃 요청
  void logOut() async {
    // 1. 토큰 꺼낸다.
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if( token == null ){ return; } // 없으면 함수 종료
    // 2. 서버에게 로그아웃 요청
    dio.options.headers['Authorization'] = token;
    final response = await dio.get( "${ServerUrl}/member/logout" );
    // 3. 전역변수(클라이언트)에도 토느 삭제
    await prefs.remove('token');
    isLogIn = null;
    // 4. 페이지 전환 이동
    Navigator.pushReplacement( context, MaterialPageRoute( builder: ( context ) => MainApp() ) );
  } // f end

  @override
  Widget build(BuildContext context) {

    // - 만약에 로그인 상태가 확인 되기 전, 대기 화면 표현
    if( isLogIn == null ){ // 만약에 비로그인이면
      return Scaffold(
        body: Center( child: CircularProgressIndicator(), ),
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all( 30 ),
        margin: EdgeInsets.all( 30 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원번호 : $mno "),

            SizedBox( height: 20 ,),

            Text("아이디(이메일) : $memail"),

            SizedBox( height: 20 ,),

            Text("이름(닉네임) : $mname"),

            SizedBox( height: 20 ,),

            ElevatedButton(
              onPressed: logOut,
              child: Text("로그아웃"),
            )
          ],
        ),
      ),
    );
  }
}