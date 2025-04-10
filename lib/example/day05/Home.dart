
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String path = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/product";

class Home extends StatefulWidget{
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State< Home >{
  Dio dio = Dio();
  List<dynamic> productList = [];

  void todoFindAll() async {
    try{
      final response = await dio.get( path );
      final data = response.data;
      if( data != null ){
        setState(() {
          productList = data;
        });
        print( productList );
      }
    }catch( e ){ print( e ); }
  }

  @override
  void initState() {
    super.initState();
    todoFindAll();
  } // f end

  void todoDelete( int id ) async {
    try{
      final response = await dio.delete( path + "?id=$id" );
      final data = response.data;
      if( data ){ todoFindAll(); }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("메인 페이지 : 비품 관리"),),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  children: productList.map( ( product ){
                    return Card( child: ListTile(
                      title: Text( "제품명 : ${ product['name'] }" ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                        children: [
                          Text( "제품 설명 : ${ product['description'] }" ),
                          Text( "제품 수량 : ${ product['quantity'] }" ),
                          Text( "등록일 : ${ product['createdate'] }" ),
                          Text( "수정일 : ${ product['updatedate'] }" ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => { Navigator.pushNamed( context, "/update", arguments: product['id'] ) },
                              icon: Icon( Icons.edit_outlined )
                          ),
                          IconButton(
                              onPressed: () => { Navigator.pushNamed( context, "/detail", arguments: product['id'] ) },
                              icon: Icon( Icons.info_outline )
                          ),
                          IconButton(
                              onPressed: () => { todoDelete( product['id'] ) },
                              icon: Icon( Icons.close )
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ),
            OutlinedButton(
                onPressed: () => { Navigator.pushNamed( context, "/write" ) },
                child: Text("비품 등록")
            )
          ],
        ),
      ),
    );
  }
}