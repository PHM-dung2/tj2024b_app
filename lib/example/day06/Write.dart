
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String bookPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/book";

class Write extends StatefulWidget{
  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State< Write >{
  final TextEditingController btitleController = new TextEditingController();
  final TextEditingController bcontentController = new TextEditingController();
  final TextEditingController bwriterController = new TextEditingController();
  final TextEditingController bpwdController = new TextEditingController();

  Dio dio = Dio();
  // 추천 책 등록
  void bookSave() async {
    final sendData = {
      "btitle" : btitleController.text,
      "bcontent" : bcontentController.text,
      "bwriter" : bwriterController.text,
      "bpwd" : bpwdController.text
    };

    try{
      final response = await dio.post( bookPath, data: sendData );
      final data = response.data;
      if( data != null ){
        Navigator.pushNamed( context, "/" );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("책 추천 등록 페이지"),),
      body: Card( child: ListTile(
        title: TextField(
          controller: btitleController,
          decoration: InputDecoration( labelText: "책 제목"),
          maxLength: 30,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: bcontentController,
              decoration: InputDecoration( labelText: "책 소개"),
              maxLines: 5,
            ),
            SizedBox( height: 30,),

            TextField(
              controller: bwriterController,
              decoration: InputDecoration( labelText: "작가명"),
              maxLength: 30,
            ),
            SizedBox( height: 30,),

            TextField(
              controller: bpwdController,
              decoration: InputDecoration( labelText: "비밀번호"),
              obscureText: true,
              maxLength: 30,
            ),

            Center(
              child: OutlinedButton(
                onPressed: bookSave,
                child: Text("등록하기")
              )
            )

          ],
        ),
      ),
      ),
    );
  }
}