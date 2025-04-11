
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String bookPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/book";

class Update extends StatefulWidget{
  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}

class _UpdateState extends State< Update >{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int bno = ModalRoute.of( context )!.settings.arguments as int;
    bookFindById( bno );
  } // f end

  Dio dio = Dio();
  Map<String, dynamic> book = {};
  // 책 추천 상세 조회
  void bookFindById( bno ) async {
    try{
      final response = await dio.get( bookPath + "/view?bno=$bno" );
      final data = response.data;
      if( data != null ){
        setState(() {
          book = data;
          btitleController.text = data['btitle'];
          bwriterController.text = data['bwriter'];
          bcontentController.text = data['bcontent'];
        });
      }
    }catch( e ){ print( e );  }
  } // f end

  TextEditingController btitleController = TextEditingController();
  TextEditingController bcontentController = TextEditingController();
  TextEditingController bwriterController = TextEditingController();
  TextEditingController bpwdController = TextEditingController();

  void bookUpdate() async {
    final sendData = {
      "btitle" : btitleController.text,
      "bwriter" : bwriterController.text,
      "bcontent" : bcontentController.text,
      "bpwd" : bpwdController.text,
      "bno" : book['bno'],
    };

    try{
      final response = await dio.put( bookPath, data: sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pop( context );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("책 추천 수정 페이지"),),
      body: Card( child: ListTile(
        title: TextField(
          controller: btitleController,
          decoration: InputDecoration( labelText: "책 제목" ),
          maxLength: 30,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: bwriterController,
              decoration: InputDecoration( labelText: "작가명" ),
              maxLength: 30,
            ),
            TextField(
              controller: bcontentController,
              decoration: InputDecoration( labelText: "책 소개" ),
              maxLines: 5,
            ),
            TextField(
              controller: bpwdController,
              decoration: InputDecoration( labelText: "비밀번호" ),
              obscureText: true,
              maxLength: 30,
            ),
            Center(
              child: OutlinedButton(
                onPressed: bookUpdate,
                child: Text("수정하기"),
              ),
            )
          ]
        ),
        ),
      )
    );
  }
}