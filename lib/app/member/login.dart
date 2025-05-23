
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/mainapp.dart';
import 'package:tj2024b_app/app/member/signup.dart';
import 'package:tj2024b_app/app/util/serverUrl.dart';

// String memberPath = 'http://192.168.40.97:8080/member';

class Login extends StatefulWidget{
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State< Login >{
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  Dio dio = Dio();

  void onLogIn() async {
    final sendData = {
      "memail" : emailController.text,
      "mpwd" : pwdController.text,
    };
    print( sendData );
    try{
      final response = await dio.post( "${ServerUrl}/member/login", data: sendData );
      final data = response.data;
      if( data != '' ){ // 로그인 성공시 토큰 SharedPreferences 저장하기
        // 1. 전역변수 호출
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // 2. 전역변수 값 추가
        await prefs.setString( 'token' , data );

        print('로그인 성공');
        // * 로그인 성공시 페이지 전환
        Navigator.pushReplacement(
          context,
          MaterialPageRoute( builder: ( context ) => MainApp() ),
        );
      }else{ print('로그인 실패'); }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all( 30 ),
        margin: EdgeInsets.all( 30 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 현재 축(Column) 기준으로 가로 또는 세로 정렬
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration( label: Text("이메일"), border: OutlineInputBorder(), ),
            ),

            SizedBox( height: 20, ),

            TextField(
              controller: pwdController,
              obscureText: true,
              decoration: InputDecoration( label: Text("비밀번호"), border: OutlineInputBorder(), ),
            ),

            SizedBox( height: 20, ),

            ElevatedButton(
              onPressed: onLogIn,
              child: Text('로그인')
            ),

            SizedBox( height: 20 ,),

            TextButton(
              onPressed: () => { Navigator.pushReplacement( context, MaterialPageRoute( builder : ( context ) => SignUp() ) ) },
              child: Text('처음 방문이면 회원가입')
            )
          ],
        ),
      ),
    );
  }
}