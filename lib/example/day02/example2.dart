
// Dart 언어는 단일 스레드 기반

// 1. Dio 객체 생성, java : new 클래스명() vs dart 클래스명()
// 2. 파일 상단에 import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
final dio = Dio(); // fianl : 상수키워드

void main(){ // main 함수가 스레드를 갖고 코드의 시발점
  print('dart start');

  postHttp(); // 해당 함수 호출
  getHttp(); // 해당 함수 호출
} // main end

// 3. dio.get( "URL" )
// dio.HTTP메소드명( "URL" ) vs axios.HTTP메소드명( "URL" )
// 테스트 : day03에서 과제 3의 TaskController에게 통신
void getHttp() async {
  try { // (4) try{}catch(e){} 예외처리
    // (1) dio 통신 이용한 자바와 통신
    final response = await dio.get("http://localhost:8080/day03/task/course");
    // (2) 응답 확인
    print(response.data);
  }catch( e ){ print( e ); }
} // f end

// 4. dio.post( "URL", data : {body} )
void postHttp() async {
  try{
    // (1) 보내고자 하는 내용물 JSON(dart map)
    final sendData = { "cname" : "수학" };
    // (2) dios 통ㅅ니 이용한 서버와 통신
    final response = await dio.post("http://localhost:8080/day03/task/course", data: sendData );
    // (3) 응답 확인
    print( response.data );
  }catch( e ){ print( e ); }
} // f end