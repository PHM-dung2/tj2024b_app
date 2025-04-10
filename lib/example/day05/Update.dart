
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String path = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/day04/product";

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
    int id = ModalRoute.of( context )!.settings.arguments as int;
    print( id );
    productFindById( id );
  } // f end

  Dio dio = Dio();
  Map<String, dynamic> product = {};

  void productFindById( id ) async {
    try{
      final response = await dio.get( path + "/view?id=$id" );
      final data = response.data;
      if( data != null ){
        setState(() {
          product = data;
          nameController.text = data['name'];
          descriptionController.text = data['description'];
          quantityController.text = data['quantity'].toString();
        });
        print( product );
      }
    }catch( e ){ print( e ); }
  } // f end

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  // 수정 함수
  void productUpdate() async {
    final sendData = {
      "id" : product['id'],
      "name" : nameController.text,
      "description" : descriptionController.text,
      "quantity" : quantityController.text
    };

    try {
      final response = await dio.put( path, data: sendData );
      final data = response.data;
      if( data ){
        Navigator.pushNamed( context, "/" );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("비품 수정 페이지"),),
      body: Center(
        child: Column(
          children: [
            SizedBox( height: 30,),
            TextField(
              controller: nameController,
              decoration: InputDecoration( labelText: "수정할 제품명"),
            ),

            SizedBox( height: 30,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration( labelText: "수정할 제품 내용"),
            ),

            SizedBox( height: 30,),
            TextField(
              controller: quantityController,
              decoration: InputDecoration( labelText: "수정할 제품 수량"),
            ),

            SizedBox( height: 30 ,),
            OutlinedButton(
                onPressed: productUpdate,
                child: Text("수정")
            ),
          ],
        )
      ),
    );
  }
}