// signup.dart : 회원가입 페이지

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State< SignUp >{

  // * 입력 컨트롤러, 각 입력창에서 입력받은 값을 제어( 반환, 호출 등등 )
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Dio dio = Dio();
  // * 등록 버튼 클릭시
  void onSignUp() async {
    // 1. 자바에 보낼 데이터 준비
    final sendData = {
      "email" : emailController.text, // 입력 컨트롤러에 입력된 값 가져오기
      "pwd" : pwdController.text,
      "name" : nameController.text,
    };
    print( sendData ); // 확인
    // final response = await dio.post('');
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all( 50 ), // EdgeInsets.all() : 상하좌우 모두 적영되는 안쪽 여백
        margin: EdgeInsets.all( 50 ),
        child: Column( // 세로배치 위젯
          children: [ // 하위 위젯
            TextField(
              controller: emailController,
              decoration: InputDecoration( label: Text("이메일"), border: OutlineInputBorder(), ),
            ), // 입력 위젯, 이메일(id)

            SizedBox( height: 20,),

            TextField(
              controller:  pwdController,
              obscureText: true, // 입력한 텍스트 가리기
              decoration: InputDecoration( label: Text("비밀번호"), border: OutlineInputBorder(), ),
            ), // 입력 위젯, 패스워드

            SizedBox( height: 20,),

            TextField(
              controller: nameController,
              decoration: InputDecoration( label: Text("닉네임"), border: OutlineInputBorder(), ),
            ), // 입력 위젯, 닉네임

            SizedBox( height: 20,),

            ElevatedButton(
                onPressed: onSignUp,
                child: Text('회원가입')
            ),
            TextButton(
                onPressed: () => {},
                child: Text('로그인')
            ),
          ],
        ),
      ),
    );
  }
}