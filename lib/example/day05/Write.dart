
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String path = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/product";

class Write extends StatefulWidget{
  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State< Write >{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  Dio dio = Dio();
  void productSave() async {
    final sendData = {
      "name" : nameController.text,
      "description" : descriptionController.text,
      "quantity" : quantityController.text,
    }; // f end

    try{
      final response = await dio.post( path, data: sendData );
      final data = response.data;
      if( data ){
        Navigator.pushNamed( context, "/" );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("비품 등록 페이지"),),
      body: Center(
        child: Column(
          children: [
            Text("비품 등록하기"),
            SizedBox( height: 30,),

            TextField(
              controller: nameController,
              decoration: InputDecoration( labelText: "상품명" ),
              maxLength: 30,
            ),
            SizedBox( height: 30,),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration( labelText: "상품 설명"),
              maxLines: 5,
            ),
            SizedBox( height: 30,),

            TextField(
              controller: quantityController,
              decoration: InputDecoration( labelText: "상품 수량"),
            ),
            SizedBox( height: 30,),

            OutlinedButton(
                onPressed: productSave,
                child: Text("등록하기")
            )

          ],
        ),
      ),
    );
  }
}