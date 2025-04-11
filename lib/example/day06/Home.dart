
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String bookPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/book";
String replyPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/reply";

class Home extends StatefulWidget{
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State< Home >{
  Dio dio = Dio();
  List<dynamic> bookList = [];

  void bookFindAll() async {
    try{
      final response = await dio.get( bookPath );
      final data = response.data;
      if( data != null ){
        setState(() {
          bookList = data;
        });
        print( bookList );
      }
    }catch( e ){ print( e ); }
  } // f end
  
  @override
  void initState() {
    super.initState();
    bookFindAll();
  } // f end
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("익명 도서 추천"),),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  children: bookList.map( (book){
                    return Card( child: ListTile(
                      title: Text("제목 : ${ book['btitle'] }"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          book['updateAt'] == null
                          ? Text( "등록일 : ${ book['createAt'] }" )
                          : Text( "등록일 : ${ book['createAt'] }" ),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed( context, "/detail", arguments: book['bno'] );
                      },
                    ),);
                  }).toList(),
                )
            ),
            OutlinedButton(
                onPressed: () => { Navigator.pushNamed( context, "/write" ) },
                child: Text("추천 책 등록")
            )
          ],
        ),
      ),
    );  
  }
} 