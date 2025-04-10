
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String path = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/product";

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
}

class _DetailState extends State< Detail >{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of( context )!.settings.arguments as int;
    productFindById( id );
  }

  Dio dio = Dio();
  Map<String, dynamic> product = {};

  void productFindById( id ) async {
    try{
      final response = await dio.get( path + "/view?id=$id" );
      final data = response.data;
      if( data != null ){
        setState(() {
          product = data;
        });
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("비품 상세 페이지") ),
      body: Card(
        child: ListTile(
          title: Text( "제품명 : ${ product['name'] }"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( "제품 설명 : ${ product['description'] }" ),
              Text( "제품 수량 : ${ product['quantity'] }" ),
              Text( "등록일 : ${ product['createdate'] }" ),
              Text( "수정일 : ${ product['updatedate'] }" ),
            ],
          ),
        )
      ),
    );
  }
}